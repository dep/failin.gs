class InvitationsController < ApplicationController
  before_filter :require_user

  respond_to :html
  respond_to :js, only: :create

  def new
    respond_with(@invitation = current_user.invitations.new)
  end

  def create
    @invitation = current_user.invitations.create(params[:invitation])
    Delayed::Job.enqueue MailJob.new(@invitation) unless @invitation.new_record?
    respond_with(@invitation, location: new_invitation_path)
  end
end
