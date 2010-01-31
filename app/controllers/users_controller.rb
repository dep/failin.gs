class UsersController < ApplicationController
  respond_to :html

  def new
    respond_with(@user = User.new)
  end

  def create
    @user = User.new params[:user]
    @user_session = UserSession.new
    if @user.save
      respond_with @user, location: edit_account_path
    else
      render "user_sessions/new"
    end
  end

  def edit
    respond_with(@user = current_user)
  end

  def update
    @user = current_user
    @user.update_attributes params[:user]
    respond_with @user, location: edit_account_path
  end

  def destroy
    @user = current_user
    current_user_session.destroy
    @user.destroy
    redirect_to root_path
  end
end
