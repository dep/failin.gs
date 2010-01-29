class CommentsController < ApplicationController
  def create
    @user = User.find_by_login! params[:login]
    @failing = @user.failings.find params[:failing_id]
    @comment = @failing.comments.new params[:comment]
    @comment.user_id = current_user.id
    @comment.submitter_ip = request.remote_ip

    if @comment.save
      redirect_to profile_url(@user)
    else
      render "failings#index"
    end
  end
end
