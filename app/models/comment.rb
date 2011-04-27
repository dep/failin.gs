class Comment < ActiveRecord::Base
  belongs_to :failing
  belongs_to :user
  has_many :abuses, as: :content

  attr_accessor :answer
  attr_accessible :text, :answer

  validates_length_of :text, in: 1..200
  validates_uniqueness_of :text, scope: :failing_id
  validate :verified, on: :create, if: :failing

  after_save :touch_user

  scope :not_abusive, where("state != ?", "abused").order("created_at ASC")

  include AASM

  aasm_column :state
  aasm_initial_state :normal

  aasm_state :normal
  aasm_state :abused

  aasm_event :abuse do
    transitions to: :abused, from: %w(normal)
  end

  def subscribers
    # Collect subscribing commentators.
    recipients = failing.comments.map { |comment|
      comment.user if comment.user && comment.user.subscribe?
    }

    # Add subscribing submitters.
    if failing.submitter && failing.submitter.subscribe?
      recipients << failing.submitter
    end

    # Get rid of nil values, the comment's own user, and the failing user.
    # (The failing user receives a different email.)
    recipients.delete_if { |recipient|
      recipient.nil? || recipient == user || recipient == failing.user
    }

    recipients.uniq
  end

  private

  def verified
    unless verify_answer
      errors[:base] << "You answered their security question incorrectly"
    end
  end

  def verify_answer
    answer.to_s.downcase.strip == failing.user.answer.downcase.strip
  end

  def touch_user
    failing.user.touch
  end
end
