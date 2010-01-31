class Vote < ActiveRecord::Base
  # = Local
  belongs_to :failing
  belongs_to :user

  validates_presence_of :failing
  validates_uniqueness_of :user_id, scope: [:failing_id, :voter_ip]
  validates_uniqueness_of :voter_ip, scope: [:failing_id, :user_id]

  attr_protected :failing_id, :user_id, :voter_ip

  scope :positive, conditions: { agree: true }
  scope :negative, conditions: { agree: false }

  after_save :update_failing

  private

  def update_failing
    if agree?
      failing.increment! :score
    else
      failing.decrement! :score
    end
  end
end
