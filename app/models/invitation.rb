class Invitation < ActiveRecord::Base
  belongs_to :inviter, class_name: "User"
  belongs_to :invited, class_name: "User"

  attr_accessible :email

  validates_presence_of :inviter, :email
  validate :should_be_invitable
  after_save :decrement_invites_left

  def save
    super
  rescue ActiveRecord::RecordNotUnique => e
    errors.add :email, "has already been invited"
  end

  private

  def should_be_invitable
    if inviter.invites_left <= 0
      errors.add :inviter, "is out of invites"
    elsif User.find_by_email(email)
      errors.add :email, "is already a member"
    end
  end

  def decrement_invites_left
    inviter.decrement! :invites_left
  end
end
