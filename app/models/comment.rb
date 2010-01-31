class Comment < ActiveRecord::Base
  belongs_to :failing
  validates_length_of :text, in: 1..145
end
