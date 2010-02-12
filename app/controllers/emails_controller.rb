class EmailsController < ApplicationController
  def create
    @email = Email.new params[:email]
    if @email.save
      respond_to do |format|
        format.html { redirect_to page_path("thankyou") }
        format.js {
          render(:update) do |page|
            page.redirect_to page_path("thankyou")
          end
        }
      end
    else
      respond_to do |format|
        format.html {
          @user         = User.new
          @user_session = UserSession.new
          render "pages#root"
        }
        format.js {
          render :update do |page|
            page[:request_form].replace partial: "users/request"
            page[:request_form].show
          end
        }
      end
    end
  end
end
