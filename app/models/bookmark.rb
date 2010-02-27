class Bookmark < ActiveRecord::Base
  belongs_to :bookmarker, class_name: "User"
  belongs_to :bookmarked, class_name: "User"
end
