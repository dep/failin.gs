class Invitation < ActiveRecord::Base
  belongs_to :inviter, class_name: "User"
  belongs_to :invited, class_name: "User"

  attr_accessible :email

  validates_presence_of :inviter, :email
  validates_format_of :email, with: Authlogic::Regex.email, message: "doesn't look like an email", allow_blank: true
  validates_uniqueness_of :email, message: "has already been invited"
  validate :should_be_invitable
  after_save :decrement_invites_left

  # TODO: Move this message (and others) into I18t.
  ALREADY_MEMBER_MESSAGE = "is already a member"

  private

  def should_be_invitable
    if inviter.invites_left <= 0
      errors[:inviter] << "is out of invites"
    elsif User.find_by_email(email)
      errors[:email] << ALREADY_MEMBER_MESSAGE
    end
  end

  def decrement_invites_left
    inviter.decrement! :invites_left
  end
end
