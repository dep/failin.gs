class Vote < ActiveRecord::Base
  # = Local
  belongs_to :failing
  belongs_to :user

  validates_presence_of :failing
  validates_uniqueness_of :user_id, scope: :failing_id
  validates_uniqueness_of :token_id, scope: %w(failing_id user_id)

  attr_accessible :agree

  scope :positive, conditions: { agree: true }
  scope :negative, conditions: { agree: false }

  after_create :update_failing

  private

  def update_failing
    if agree?
      failing.increment! :score
    else
      failing.decrement! :score
    end
  end
end
