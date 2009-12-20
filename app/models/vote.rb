class Vote < ActiveRecord::Base
  # = Local
  belongs_to :failing

  named_scope :positive, conditions: { agree: true }
  named_scope :negative, conditions: { agree: false }
end
