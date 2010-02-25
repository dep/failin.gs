class FriendsController < ApplicationController
  before_filter :require_user

  def twitter
    if current_user.twitter?
      @friends   = User.find_all_by_twitter_id current_user.twitter.friend_ids
      @followers = User.find_all_by_twitter_id current_user.twitter.follower_ids
    end
  end
end
