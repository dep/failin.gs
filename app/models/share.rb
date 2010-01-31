class Share < ActiveRecord::Base
  belongs_to :user
  attr_accessible :emails
  validates_presence_of :user, :emails
  validate :emails_should_all_be_valid

  private

  def emails_should_all_be_valid
    invalid = emails.split(/,\s*/).inject([]) do |array, email|
      array << %{"#{email}"} unless email =~ Authlogic::Regex.email
      array
    end

    if invalid.any?
      errors[:emails] << "#{invalid.to_sentence} not valid"
    end
  end
end
