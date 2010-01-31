class SharesController < ApplicationController
  before_filter :require_user

  def create
    @invitation = current_user.invitations.new
    @share = current_user.shares.new(params[:share])
    if @share.save
      Delayed::Job.enqueue MailJob.new(@share)

      respond_to do |format|
        format.html { redirect_to new_invitation_path }
        format.js {
          render :update do |page|
            @share = Share.new
            page[@share].replace_html partial: "form"
            page.insert_html :top, dom_id(@share), "Thanks for inviting your friends!"
          end
        }
      end
    else
      respond_to do |format|
        format.html { render "invitations/new" }
        format.js {
          render :update do |page|
            page[@share].replace_html partial: "form"
          end
        }
      end
    end
  end
end
