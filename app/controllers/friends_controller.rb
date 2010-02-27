class FriendsController < ApplicationController
  before_filter :require_user

  def create
    render :update do |page|
      if @user = User.find_by_login(params[:user_id])
        current_user.bookmarked << @user unless current_user.bookmarked.include? @user

        page << "if ($('#{dom_id @user, :bookmark}')) {"
        page[dom_id(@user, :bookmark)].replace partial: "failings/bookmark", object: @user
        page << "}"
        page << "bindBookmarkEvents();"
      end
    end
  end

  def destroy
    render :update do |page|
      @user = User.find_by_login params[:user_id]
      if current_user.bookmarked.include?(@user)
        current_user.bookmarked.delete(@user)

        page << "if ($('#{dom_id @user, :bookmark}')) {"
        page[dom_id(@user, :bookmark)].replace partial: "failings/bookmark", object: @user
        page << "}"

        page << "bindBookmarkEvents();"

        page << "if ($$('.bookmarks').first() && $$('.bookmarks li').length === 0) {"
        page.select(".sub_nav_body").first.replace partial: "no_bookmarks"
        page << "}"
      end
    end
  end

  def twitter
    if current_user.twitter?
      @friends   = User.find_all_by_twitter_id current_user.twitter.friend_ids
      @followers = User.find_all_by_twitter_id current_user.twitter.follower_ids
    end
  end
end
