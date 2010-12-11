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

        page << "if ($('sub_nav_body') && $$('ul.bookmarks li').length === 0) {"
        page[:sub_nav_body].replace_html partial: "no_bookmarks"
        page << "}"
      end
    end
  end

  def twitter
    if current_user.twitter?
      @friends   = current_user.twitter_friends
      @followers = current_user.twitter_followers
    end
  end

  def facebook
    if current_user.facebook?
      @friends = current_user.facebook_friends
    end
  end
end
