class UsersController < ApplicationController
  before_filter :require_user, only: %w(edit update destroy)
  before_filter :require_no_user, only: %w(new create)

  respond_to :html

  def create
    @user = User.new params[:user]
    @user.promo_code = params[:promo_code] if params[:promo_code]
    @user_session = UserSession.new
    if @user.save
      if @user.invitation
        Delayed::Job.enqueue MailJob.new(@user)
      end
      respond_with @user, location: edit_account_path
    else
      render "user_sessions/new"
    end
  end

  def edit
    @user = current_user
    return unless stale? etag: @user, public: false
    respond_with @user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Updated!"
    end
    respond_with @user, location: edit_account_path
  end

  def destroy
    @user = current_user
    current_user_session.destroy
    @user.destroy
    redirect_to root_path
  end
end
