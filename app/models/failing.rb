class Failing < ActiveRecord::Base
  # = Local
  belongs_to :user
  has_many :votes
  has_many :comments

  attr_accessor :surname
  validate :verify_surname, on: :create

  scope :needs_review, where(state: "needs_review")
  scope :knew,         where(state: "knew")
  scope :no_idea,      where(state: "no_idea")
  scope :disagree,     where(state: "disagree")

  include ActiveRecord::StateMachine
  state_machine do
    state :needs_review
    state :knew
    state :no_idea
    state :disagree

    event :knew do
      transitions to: :knew, from: %w(needs_review no_idea disagree)
    end

    event :no_idea do
      transitions to: :no_idea, from: %w(needs_review knew disagree)
    end

    event :disagree do
      transitions to: :disagree, from: %w(needs_review knew no_idea)
    end
  end

  def votes_score
    votes.positive.count - votes.negative.count
  end

  private

  def verify_surname
    if @surname.downcase != user.surname.downcase
      errors.add :surname, "doesn't match."
    end
  end
end
