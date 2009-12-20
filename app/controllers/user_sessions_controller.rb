class UserSessionsController < ApplicationController
  before_filter :require_no_user, only: %w(new create)
  before_filter :require_user, only: "destroy"

  def new
    respond_with(@user_session = UserSession.new)
  end

  def create
    @user_session = UserSession.create params[:user_session]
    if @user_session.save
      redirect_back_or_default account_url, notice: "Login successful!"
    else
      render "new"
    end
  end

  def destroy
    current_user_session.destroy
    redirect_back_or_default new_user_session_path,
      notice: "Logout successful!"
  end
end
