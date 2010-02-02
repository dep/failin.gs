class SharesController < ApplicationController
  before_filter :require_user

  def new
    @share = current_user.shares.new
  end

  def create
    @share = current_user.shares.new(params[:share])
    if @share.save
      Delayed::Job.enqueue MailJob.new(@share)

      respond_to do |format|
        format.html { redirect_to new_share_path }
        format.js {
          render :update do |page|
            @share = Share.new
            page[@share].replace_html partial: "form"
            page.insert_html :top, dom_id(@share), "<p class='success_text'>Thanks for inviting your friends!</p>"
          end
        }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js {
          render :update do |page|
            page[@share].replace_html partial: "form"
          end
        }
      end
    end
  end
end
