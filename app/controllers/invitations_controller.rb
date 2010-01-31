class InvitationsController < ApplicationController
  before_filter :require_user

  respond_to :html
  respond_to :js, only: %w(create invite_criticism)

  def new
    return unless stale? etag: current_user.invites_left, public: false
    @share = current_user.shares.new
    respond_with(@invitation = current_user.invitations.new)
  end

  def create
    @invitation = current_user.invitations.create(params[:invitation])
    Delayed::Job.enqueue MailJob.new(@invitation) unless @invitation.new_record?
    respond_with(@invitation, location: new_invitation_path)
  end
end
