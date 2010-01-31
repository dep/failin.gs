class Comment < ActiveRecord::Base
  belongs_to :failing
  validates_length_of :text, in: 1..145
  after_save :touch_user

  private

  def touch_user
    failing.user.touch
  end
end
