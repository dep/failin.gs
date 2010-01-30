class FailingsController < ApplicationController
  respond_to :html

  def index
    @user = User.find_by_login! params[:login]
    @failing = @user.failings.build
  end

  def create
    @user = User.find_by_login! params[:login]
    @failing = @user.failings.new params[:failing]
    if @failing.save
      redirect_to profile_path(@user)
    else
      render "index"
    end
  end

  def knew
#    @failing = current_user.failings.needs_review.find(params[:id])
#    @failing.knew!
#    redirect_to profile_path(current_user)

    render :update do |page|
      page << "categorize('knew', '#{current_user.failings.needs_review.find(params[:id])}')"
    end
  end

  def no_idea
    @failing = current_user.failings.needs_review.find(params[:id])
    @failing.no_idea!
    redirect_to profile_path(current_user)

    render :update do |page|
      page << "categorize('no_idea')"
    end
  end

  def disagree
    @failing = current_user.failings.needs_review.find(params[:id])
    @failing.disagree!
    redirect_to profile_path(current_user)

    render :update do |page|
      page << "categorize('disagree')"
    end
  end
end
