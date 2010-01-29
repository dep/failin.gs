class Vote < ActiveRecord::Base
  # = Local
  belongs_to :failing
  validates_presence_of :failing
  validates_uniqueness_of :user_id, scope: :failing_id
  validates_uniqueness_of :voter_ip, scope: :failing_id

  scope :positive, conditions: { agree: true }
  scope :negative, conditions: { agree: false }

  def agree!
    self.agree = true
    save!
  end

  def disagree!
    self.agree = false
    save!
  end
end
