class AbusesController < ApplicationController
  def create
    @user = User.find_by_login! params[:login]
    @failing = @user.failings.find params[:failing_id]
    @abuse = @failing.abuses.new
    @abuse.user = current_user
    @abuse.reporter_ip = request.remote_ip

    if @abuse.save
      respond_to do |format|
        format.html { redirect_to profile_url(@user) }
        format.js {
          render :update do |page|
            page[@failing].select(".abuse").first.replace "thanks!"
          end
        }
      end
    else
      respond_to do |format|
        format.html { render "failings#index" }
        format.js {
          render :update do |page|
            page.alert "You've already reported this abuse!" # @abuse.errors.full_messages.join(". ")
          end
        }
      end
    end
  end
end
