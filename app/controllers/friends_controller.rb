class FriendsController < ApplicationController
  before_filter :require_user

  def twitter
    if current_user.twitter?
      @friends   = User.find_all_by_twitter_id current_user.twitter.friend_ids
      @followers = User.find_all_by_twitter_id current_user.twitter.follower_ids
    end
  end

  def facebook
    # if current_user.facebook?
    #   @friends = User.find_all_by_facebook_uid current_user.facebook.friend_ids
    # end
  end
end
