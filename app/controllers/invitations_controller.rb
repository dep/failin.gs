class InvitationsController < ApplicationController
  before_filter :require_user

  def new
    return unless stale? etag: current_user.invites_left, public: false
    @share = current_user.shares.new
    respond_with(@invitation = current_user.invitations.new)
  end

  def create
    @share = current_user.shares.new
    @invitation = current_user.invitations.new(params[:invitation])
    if @invitation.save
      Delayed::Job.enqueue MailJob.new(@invitation)
      respond_to do |format|
        format.html { redirect_to new_invitation_path }
        format.js {
          render :update do |page|
            email = @invitation.email
            @invitation = Invitation.new
            page[@invitation].replace partial: "form"
            page.insert_html :top, dom_id(@invitation), "Thanks for inviting #{email}!"
            page["invites_left"].replace_html current_user.invites_left - 1
            page["invites_left"].visual_effect :highlight
          end
        }
      end
    else
      respond_to do |format|
        format.html { render "new" }
        format.js {
          render :update do |page|
            page[@invitation].replace partial: "form"
          end
        }
      end
    end
  end
end
