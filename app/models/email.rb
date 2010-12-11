class Email < ActiveRecord::Base
  belongs_to :user

  attr_accessible :address

  validates_format_of :address, with: /^.+@.+$/,
    message: "doesn't look like an email"

  class << self
    def invite!(limit = 100)
      where("created_at = updated_at").order("created_at ASC").limit(limit).
        each do |email|

        logger.info "Inviting '#{email.address}'..."
        email.invite!
        sleep 1
      end
    end
  end

  def save
    super
  rescue ActiveRecord::RecordNotUnique => e
    errors.add :address, "has already signed up"
    false
  end

  def invite!
    return false unless created_at == updated_at

    inviter = User.find_by_login! "failings"
    invited = inviter.invitations.new(email: address)
    if invited.save
      touch
      MailJob.perform invited.class.name, invited.id
    end
  end
end
