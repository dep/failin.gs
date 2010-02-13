class AbusesController < ApplicationController
  respond_to :js

  before_filter :load_failing

  def create
    @abuse = Abuse.new user: current_user, reporter_ip = request.remote_ip

    if params[:comment_id]
      @abuse.content = @failing.comments.find params[:comment_id]
      @abuse.save
      render "abused_comment"
    else
      @abuse.content = @failing
      @abuse.save
      render "abused_failing"
    end
  end
end
