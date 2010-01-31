class UserSessionsController < ApplicationController
  respond_to :html

  before_filter :require_no_user, only: %w(new create)

  def new
    @user = User.new
    return unless stale? etag: @user
    respond_with(@user_session = UserSession.new)
  end

  def create
    @user = User.new
    @user_session = UserSession.new params[:user_session]
    if @user_session.save
      redirect_back_or_default profile_path(@user_session.user),
        notice: "Login successful!"
    else
      render "new"
    end
  end

  def destroy
    current_user_session.destroy if current_user_session
    redirect_back_or_default root_path
  end
end
