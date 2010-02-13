class AbusesController < ApplicationController
  def create
    @user = User.find_by_login! params[:login]
    @failing = @user.failings.find params[:failing_id]
    @state_was = @failing.state if @user == current_user
    @abuse = @failing.abuses.new
    @abuse.user = current_user
    @abuse.reporter_ip = request.remote_ip

    if @abuse.save
      respond_to do |format|
        format.html { redirect_to profile_url(@user) }
        format.js {
          render :update do |page|
            if @user == current_user
              page[@failing].visual_effect(:blind_up, duration: 0.1)
              page.delay(0.1) do
                page[@failing].remove

                page << "if ($$('##@state_was .failing').length == 0) {"
                  page << "$$('##@state_was .empty')[0].show();"
                  if @state_was == "needs_review"
                    page[@state_was].up(".flaw_box").hide
                  end
                page << "}"
              end

            else
              page[@failing].select(".abuse").first.replace "thanks!"
            end
          end
        }
      end
    else
      respond_to do |format|
        format.html { render "failings/index" }
        format.js {
          render :update do |page|
            page[@failing].select(".abuse").first.replace "already reported!"
          end
        }
      end
    end
  end
end
