class User < ActiveRecord::Base
  acts_as_authentic # { |config| config.remember_me = true }

  has_many :failings

  belongs_to :promotion
  belongs_to :invitation, foreign_key: :invited_id
  has_many :invitations, foreign_key: :inviter_id
  has_many :invited, through: :invitations

  LOGIN_LENGTH = 1..17
  validates :login, length: LOGIN_LENGTH, format: /\w+/
  validates_presence_of :surname
  validate :promotion_should_be_valid, if: :promotion_id?
  validate :should_be_invited if App.beta?

  def to_param
    login
  end

  private

  def promotion_should_be_valid
    if promotion.users.count >= limit
      errors[:promotion] << "has ended"
    end
  end
end
