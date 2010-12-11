class InvitationsController < ApplicationController
  before_filter :require_user

  def new
    etag = [current_user.invites_left, form_authenticity_token]
    return unless stale? etag: etag, public: false
    @invitation = current_user.invitations.new
    @share = current_user.shares.new
  end

  def create
    @invitation = current_user.invitations.new(params[:invitation])
    @share = current_user.shares.new
    if @invitation.save
      Resque.enqueue MailJob, @invitation.class.name, @invitation.id
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
            if Array(@invitation.errors[:email]).include?(Invitation::ALREADY_MEMBER_MESSAGE)
              flash[:notice] = Invitation::ALREADY_MEMBER_MESSAGE
              page.redirect_to profile_path(User.find_by_email(@invitation.email))
            else
              page[@invitation].replace partial: "form"
            end
          end
        }
      end
    end
  end

  def search
    email = params[:email_query]
    user = User.find_by_email email
    if user
      redirect_to profile_path(user)
    else
      already_invited = !Invitation.where(email: email).count.zero?

      if (!App.beta? || current_user.invites_left > 0) && !already_invited
        @invitation = current_user.invitations.new email: email
        @share = current_user.shares.new
        flash.now[:notice] = "#{email} not found. Invite them?"

        render "new"
      else
        @invitation = current_user.invitations.new
        @share = current_user.shares.new emails: email

        flash.now[:notice] = if already_invited
          "Waiting for #{email} to join. Share with them?"
        else
          "#{email} not found. Share with them?"
        end

        render "shares/new"
      end
    end
  end

  private

  def invitable?(email)
      Invitation.where(email: email).count.zero?
  end
end
