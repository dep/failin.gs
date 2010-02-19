class Comment < ActiveRecord::Base
  belongs_to :failing
  belongs_to :user
  has_many :abuses, as: :content

  attr_accessible :text

  validates_length_of :text, in: 1..200
  validates_uniqueness_of :text, scope: :failing_id

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

  private

  def touch_user
    failing.user.touch
  end
end
