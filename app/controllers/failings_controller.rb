class FailingsController < ApplicationController
  respond_to :html

  def index
    @user = User.find_by_login! params[:login]
    @failing = @user.failings.build
  end

  def create
    @user = User.find_by_login! params[:login]
    @failing = @user.failings.new params[:failing]
    @failing.submitter = current_user
    @failing.submitter_ip = request.remote_ip

    if @failing.save
      redirect_to profile_path(@user)
    else
      render "index"
    end
  end

  def knew
    @failing = current_user.failings.find(params[:id])
    @state_was = @failing.state
    @failing.knew!

    render :update do |page|
      page[@failing].visual_effect(:blind_up, duration: 0.1)
      page.delay(0.1) do
        page[@failing].remove
        page << "$$('#knew .empty')[0].hide();"
        page.insert_html :top, "knew", partial: @failing
        page << "if (!$('knew').visible()) {"
          page["knew"].visual_effect(:highlight) # blind_down, duration: 0.2)
        page << "}"
        page[@failing].visual_effect(:highlight) # blind_down, duration: 0.2)
        page << "if ($$('##@state_was .failing').length == 0) {"
          page << "$$('##@state_was .empty')[0].show();"
          if @state_was == "needs_review"
            page[@state_was].up(".flaw_box").hide # visual_effect(:blind_up, duration: 0.2)
          end
        page << "}"
      end
    end
  end

  def no_idea
    @failing = current_user.failings.find(params[:id])
    @state_was = @failing.state
    @failing.no_idea!

    render :update do |page|
      page[@failing].visual_effect(:blind_up, duration: 0.1)
      page.delay(0.1) do
        page[@failing].remove
        page << "$$('#no_idea .empty')[0].hide();"
        page.insert_html :top, "no_idea", partial: @failing
        page << "if (!$('no_idea').visible()) {"
          page["no_idea"].show # visual_effect(:highlight) # blind_down, duration: 0.2)
        page << "}"
        page[@failing].visual_effect(:highlight) # blind_down, duration: 0.2)
        page << "if ($$('##@state_was .failing').length == 0) {"
          page << "$$('##@state_was .empty')[0].show();"
          if @state_was == "needs_review"
            page[@state_was].up(".flaw_box").hide # visual_effect(:blind_up, duration: 0.2)
          end
        page << "}"
      end
    end
  end

  def disagree
    @failing = current_user.failings.find(params[:id])
    @state_was = @failing.state
    @failing.disagree!

    render :update do |page|
      page[@failing].visual_effect(:blind_up, duration: 0.1)
      page.delay(0.1) do
        page[@failing].remove
        page << "$$('#disagree .empty')[0].hide();"
        page.insert_html :top, "disagree", partial: @failing
        page << "if (!$('disagree').visible()) {"
          page["disagree"].show # visual_effect(:highlight) # blind_down, duration: 0.2)
        page << "}"
        page[@failing].visual_effect(:highlight) # blind_down, duration: 0.2)
        page << "if ($$('##@state_was .failing').length == 0) {"
          page << "$$('##@state_was .empty')[0].show();"
          if @state_was == "needs_review"
            page[@state_was].up(".flaw_box").hide # visual_effect(:blind_up, duration: 0.2)
          end
        page << "}"
      end
    end
  end
end
