class User < ActiveRecord::Base
  # == Authlogic

  acts_as_authentic { |config|
    config.validations_scope = :state
  }


  # == Associations

  has_many :failings

  has_many :bookmarks, foreign_key: :bookmarker_id
  has_many :bookmarked, through: :bookmarks

  belongs_to :promotion
  has_one :invitation, foreign_key: :invited_id
  has_one :inviter, through: :invitation

  has_many :invitations, foreign_key: :inviter_id
  has_many :invited, through: :invitations

  has_many :shares


  # == Attributes

  attr_reader :promo_code
  attr_accessor :updating_password

  attr_accessible :login, :email, :password, :password_confirmation, :name,
    :location, :about, :question, :answer, :subscribe, :promo_code,
    :invitation_email, :private

  serialize :preferences, Hash

  # TODO: Unset 'hide_public_notice' when user goes private.
  def preferences
    self[:preferences] ||= {}
  end


  # == Validations and Lifecycle

  APP_LOGIN = "failings"
  LOGIN_LENGTH = 1..17
  validates :login, length: LOGIN_LENGTH

  RESERVED_LOGINS = %w(admin superuser moderator login logout user_session
    users account profile pages javascripts stylesheets oauth_login
    oauth_complete oauth_delete)
  validates_exclusion_of :login, in: RESERVED_LOGINS
  validates_format_of :login, with: /^[0-9a-z_]+$/i,
    message: "can only contain letters, numbers, and underscores."
  validates_presence_of :question, :answer
  validate :promotion_should_be_valid, on: :create

  validates_length_of :question, maximum: 200
  validates_length_of :answer, maximum: 100
  validates_length_of :name, maximum: 200, allow_blank: true
  validates_length_of :about, maximum: 500, allow_blank: true

  INVALID_PASSWORDS = %w(password)
  validates_exclusion_of :password, in: INVALID_PASSWORDS, allow_blank: true,
    message: "should be a little less common than that"

  validates :password, presence: true, if: :updating_password

  validate :oauth_token_should_be_unique

  if App.beta?
    validates_presence_of :invitation, unless: :promo_code?, on: :create
  end

  after_create :set_invitation


  # == AASM

  include AASM

  aasm_column :state
  aasm_initial_state :active

  aasm_state :active
  aasm_state :deleted
  aasm_state :abused

  aasm_event :delete do
    transitions to: :deleted, from: %w(active)
  end

  aasm_event :abuse do
    transitions to: :abused, from: %w(active)
  end

  aasm_event :activate do
    transitions to: :active, from: %w(deleted abused)
  end

  scope :active,  where(state: "active")
  default_scope active

  scope :deleted, with_exclusive_scope { where state: "deleted" }
  scope :abused,  with_exclusive_scope { where state: "abused" }
  scope :any,     with_exclusive_scope {}


  class << self
    def find_by_login_or_email(login_or_email)
      if login_or_email.include?("@")
        find_by_email(login_or_email)
      else
        find_by_login(login_or_email)
      end
    end
  end


  # == Public methods

  def to_param
    login
  end

  def invitation_email
    @invitation_email
  end

  def invitation_email=(email)
    unless email.blank?
      self.invitation = Invitation.find_by_email(@invitation_email = email)
    end
  end

  def email=(email)
    super
    self.invitation ||= Invitation.find_by_email(email)
  end

  def promo_code
    promotion.code if promotion
  end

  def promo_code=(promo_code)
    self.promotion = Promotion.find_by_code promo_code
  end

  def promo_code?
    !promo_code.blank?
  end

  def profile_empty?
    failings.where("state != ?", "abused").count.zero?
  end

  def twitter?
    twitter_screen_name?
  end

  def twitter
    return @twitter if defined? @twitter

    @twitter = if twitter?
      consumer = OAuth::Consumer.new App.twitter[:key],
        App.twitter[:secret], site: 'https://api.twitter.com',
        authorize_path: '/oauth/authenticate'
      OAuth::AccessToken.new consumer, oauth_token, oauth_secret
    end
  end

  def twitter_friend_ids
    return @twitter_friend_ids if defined? @twitter_friend_ids

    @twitter_friend_ids = if twitter?
      res = twitter.get "/1/friends/ids.json?user_id=#{twitter_id}"
      JSON.parse res.body
    else
      []
    end
  end

  def twitter_follower_ids
    return @twitter_follower_ids if defined? @twitter_follower_ids

    @twitter_follower_ids = if twitter?
      res = twitter.get "/1/followers/ids.json?user_id=#{twitter_id}"
      JSON.parse res.body
    else
      []
    end
  end

  def facebook?
    facebook_id?
  end

  def facebook
    return @facebook if defined? @facebook

    @facebook = if facebook?
      client = OAuth2::Client.new App.facebook[:key],
        App.facebook[:secret], site: 'https://graph.facebook.com'
      OAuth2::AccessToken.new client, facebook_token
    end
  end

  def facebook_friend_ids
    return @facebook_friend_ids if defined? @facebook_friend_ids

    @facebook_friend_ids = if facebook?
      res = facebook.get '/me/friends'
      JSON.parse(res)["data"].map { |friend| friend["id"] }
    else
      []
    end
  end

  def avatar_service
    @avatar_service ||= begin
      service = case preferences["avatar_service"]
      when "facebook"
        facebook? ? "facebook" : "gravatar"
      when "twitter"
        twitter? ? "twitter" : "gravatar"
      else
        "gravatar"
      end

      ActiveSupport::StringInquirer.new service
    end
  end

  def apply_auth(auth)
    return unless auth

    case auth["provider"]
    when 'facebook'
      self.facebook_id         = auth["uid"]
      self.facebook_token      = auth["credentials"]["token"]
    when 'twitter'
      self.twitter_screen_name = auth["user_info"]["nickname"]
      self.twitter_id          = auth["uid"]
      self.oauth_token         = auth["credentials"]["token"]
      self.oauth_secret        = auth["credentials"]["secret"]
    end

    self.name                          ||= auth["name"]
    self.preferences["avatar_service"] ||= auth["provider"]
  end

  def app?
    login == APP_LOGIN
  end

  private

  def set_invitation
    if invitation
      invitation.invited_id = id
      invitation.save!
    end

    if address = Email.find_by_address(email)
      address.user_id = id
      address.save!
    end
  end

  def promotion_should_be_valid
    if promotion_id?
      if promo_code.present? && promotion.nil?
        errors[:promo_code] << "is invalid"
      elsif promotion.users.count >= promotion.limit
        errors[:promotion] << "has ended"
      end
    elsif App.beta? && email? && invitation.nil?
      errors[:promo_code] << "required for uninvited '#{email}'"
    end
  end

  def oauth_token_should_be_unique
    unless User.where("id <> ? AND oauth_token = ?", id.to_i, oauth_token).count.zero?
      errors[:base] << "Twitter account is already linked to another failin.gs profile."
    end
  end
end
