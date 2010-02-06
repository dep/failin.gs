class Failing < ActiveRecord::Base
  # = Local
  belongs_to :user
  belongs_to :submitter, class_name: "User"
  has_many :votes
  has_many :comments
  has_many :abuses, as: :content

  attr_accessor :surname
  validates_presence_of :user
  validates_length_of :about, in: 1..145
  validate :verified, on: :create, if: :user

  after_save :touch_user

  scope :needs_review, where(state: "needs_review").order("score DESC")
  scope :knew,         where(state: "knew").order("score DESC")
  scope :no_idea,      where(state: "no_idea").order("score DESC")
  scope :disagree,     where(state: "disagree").order("score DESC")

  include AASM

  aasm_column :state
  aasm_initial_state :needs_review

  aasm_state :needs_review
  aasm_state :knew
  aasm_state :no_idea
  aasm_state :disagree
  aasm_state :abused

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
    transitions to: :abuse, from: %w(needs_review knew no_idea disagree)
  end

  def votes_score
    score
  end

  private

  def verified
    unless verify_surname || already_verified
      errors.add :surname, "doesn't match"
    end
  end

  def verify_surname
    surname.to_s.downcase == user.surname.downcase
  end

  def already_verified
    false
    # !user.failings.
    #   where("submitter_ip = ? OR submitter_id = ?", submitter_ip, submitter_id).
    #   first.nil?
  end

  def touch_user
    user.touch
  end
end
