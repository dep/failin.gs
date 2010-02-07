class User < ActiveRecord::Base
  acts_as_authentic # { |config| config.remember_me = true }

  has_many :failings

  belongs_to :promotion
  has_one  :invitation,  foreign_key: :invited_id
  has_one  :inviter,     through: :invitation

  has_many :invitations, foreign_key: :inviter_id
  has_many :invited,     through: :invitations

  has_many :shares

  attr_reader :promo_code
  attr_accessor :updating_password

  LOGIN_LENGTH = 1..17
  validates :login, length: LOGIN_LENGTH, format: /\w+/
  validates_presence_of :surname
  validate :promotion_should_be_valid, on: :create

  validates_presence_of :password, if: :updating_password

  if App.beta?
    validates_presence_of :invitation, unless: :promo_code?, on: :create
  end

  def to_param
    login
  end

  def invitation_email
    @invitation_email
  end

  def invitation_email=(email)
    unless email.blank?
      self.invitation = Invitation.find_by_email!(@invitation_email = email)
    end
  end

  def email=(email)
    super
    self.invitation ||= Invitation.find_by_email(email)
  end

  def promo_code=(promo_code)
    @promo_code = promo_code
    self.promotion = Promotion.find_by_code promo_code
  end

  def promo_code?
    !@promo_code.blank?
  end

  private

  def promotion_should_be_valid
    if promotion_id?
      if promo_code.present? && promotion.nil?
        errors[:promo_code] << "is invalid"
      elsif promotion.users.count >= limit
        errors[:promotion] << "has ended"
      end
    elsif App.beta? && email? && invitation.nil?
      errors[:promo_code] << "required for uninvited '#{email}'"
    end
  end
end
