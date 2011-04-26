class Failing < ActiveRecord::Base
  # The number of failings a submitter can submit before deemed overkill.
  OVERKILL_LIMIT = 3

  belongs_to :user, touch: true
  belongs_to :submitter, class_name: "User"
  has_many :votes
  has_many :comments
  has_many :abuses, as: :content

  attr_accessor :answer
  attr_accessible :about, :answer

  validates_presence_of :user
  validates_length_of :about, in: 1..145
  validates_uniqueness_of :about, scope: :user_id
  validate :verified, on: :create, if: :user
  validate :overkill, on: :create, unless: :autodidact?

  scope :needs_review, where(state: "needs_review").order("created_at DESC")
  scope :reviewed,     where("state NOT IN (?)", %w(needs_review abused))
  scope :knew,         where(state: "knew").order("score DESC")
  scope :no_idea,      where(state: "no_idea").order("score DESC")
  scope :disagree,     where(state: "disagree").order("score DESC")
  scope :archived,     where(state: "archived").order("created_at DESC")

  scope :submitted_by, lambda { |user, token_id|
    user_id = user.id if user
    where(submitter_id: user_id, token_id: token_id, state: %w(needs_review abused))
  }

  include AASM

  aasm_column :state
  aasm_initial_state :needs_review

  aasm_state :needs_review
  aasm_state :knew
  aasm_state :no_idea
  aasm_state :disagree
  aasm_state :abused
  aasm_state :archived

  aasm_event :knew do
    transitions to: :knew, from: %w(needs_review no_idea disagree)
  end

  aasm_event :no_idea do
    transitions to: :no_idea, from: %w(needs_review knew disagree)
  end

  aasm_event :disagree do
    transitions to: :disagree, from: %w(needs_review knew no_idea)
  end

  aasm_event :abuse do
    transitions to: :abused, from: %w(needs_review knew no_idea disagree)
  end

  aasm_event :archive do
    transitions to: :archived, from: %w(knew no_idea disagree)
  end

  def votes_score
    score
  end

  def autodidact?
    user_id == submitter_id
  end

  private

  def verified
    errors[:answer] << "doesn't match" unless verify_answer
  end

  def overkill
    count = user.failings.where("token_id = ? OR submitter_id = ?",
      token_id, submitter_id).count

    limit = user.app? ? 100 : OVERKILL_LIMIT

    if count >= limit
      errors[:submitter] << "has submitted enough failings for this user"
    end
  end

  def verify_answer
    answer.to_s.downcase.strip == user.answer.downcase.strip
  end
end
