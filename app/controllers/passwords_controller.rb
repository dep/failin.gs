class PasswordsController < ApplicationController
  before_filter :require_no_user
  before_filter :require_perishable_token, only: %w(edit update)

  def new
    @password_reset = PasswordReset.new
  end

  def create
    @password_reset = PasswordReset.new params[:password_reset]
    if @password_reset.save
      respond_to do |format|
        format.html {
          redirect_to new_password_path,
            notice: "Check your email for instructions to reset your password."
        }
        format.js {
          render :update do |page|
            page[PasswordReset.new].reset
            page.alert "Check your email for instructions to reset your password."
          end
        }
      end
    else
      respond_to do |format|
        format.html { render "new" }
        format.js {
          render :update do |page|
            page[@password_reset].replace partial: "form"
          end
        }
      end
    end
  end

  def edit
  end

  def update
    @user.updating_password = true
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save
      UserSession.create(@user)
      respond_to do |format|
        format.html { redirect_to profile_path(@user) }
        format.js {
          render :update do |page|
            page.redirect_to profile_path(@user)
          end
        }
      end
    else
      respond_to do |format|
        format.html { render "edit" }
        format.js {
          render :update do |page|
            page["edit_password_reset"].replace partial: "edit_form"
          end
        }
      end
    end
  end

  private

  def require_perishable_token
    @user = User.find_using_perishable_token params[:perishable_token]
    render text: "Sorry, we can't find that account.", status: :not_found if @user.blank?
  end
end
