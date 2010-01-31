class Comment < ActiveRecord::Base
  belongs_to :failing
  belongs_to :user
  validates_length_of :text, in: 1..200
  after_save :touch_user

  private

  def touch_user
    failing.user.touch
  end
end
