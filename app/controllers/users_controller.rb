class UsersController < ApplicationController
  respond_to :html

  def new
    respond_with(@user = User.new)
  end

  def create
    respond_with(@user = User.create(params[:user]), location: edit_user_path)
  end

  def edit
    respond_with(@user = current_user)
  end

  def update
    @user = current_user
    @user.update_attributes params[:user]
    respond_with @user, location: edit_user_path
  end

  def destroy
    @user = current_user
    current_user_session.destroy
    @user.destroy
    redirect_to root_path
  end
end