class AbusesController < ApplicationController
  respond_to :js

  before_filter :load_failing

  def create
    @abuse = Abuse.new
    @abuse.user = current_user
    @abuse.reporter_ip = request.remote_ip
    @abuse.token_id = @identity

    if params[:comment_id]
      @comment = @failing.comments.find params[:comment_id]
      @abuse.content = @comment
      @abuse.save
      render "abused_comment"
    else
      @state_was = @failing.state
      @abuse.content = @failing
      @abuse.save
      render "abused_failing"
    end
  end
end
