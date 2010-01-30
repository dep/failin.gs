class Failing < ActiveRecord::Base
  # = Local
  belongs_to :user
  belongs_to :submitter, class_name: "User"
  has_many :votes
  has_many :comments

  attr_accessor :surname
  validate :verified, on: :create

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
    self.class.count_by_sql <<SQL
select (
  select count(*) from votes where votes.failing_id = #{id}
  and votes.agree = 1
) - (
  select count(*) from votes where votes.failing_id = #{id}
  and votes.agree = 0
) as score;
SQL
  end

  private

  def verified
    unless verify_surname || already_verified
      errors.add :surname, "doesn't match"
    end
  end

  def verify_surname
    @surname.downcase == user.surname.downcase
  end

  def already_verified
    false
    # !user.failings.
    #   where("submitter_ip = ? OR submitter_id = ?", submitter_ip, submitter_id).
    #   first.nil?
  end
end
