class CommentsController < ApplicationController
  respond_to :js

  def create
    @user = User.find_by_login! params[:login]
    @failing = @user.failings.find params[:failing_id]
    @comment = @failing.comments.new params[:comment]
    @comment.user = current_user
    @comment.submitter_ip = request.remote_ip
    @comment.token_id = @identity

    if @comment.save
      Delayed::Job.enqueue MailJob.new(@comment)

      render :update do |page|
        page.insert_html :bottom, dom_id(@failing, :comments),
          partial: @comment
        page[@comment].visual_effect :highlight
        page[@failing].select('.reply_wrapper').first.hide.select("form").
          first.reset
      end
    else
      render :update do |page|
        page.alert @comment.errors.full_messages.join(". ")
      end
    end
  rescue ActiveRecord::RecordNotUnique
    logger.info "Ignoring duplicate comment #{@comment.inspect}"
    head :unprocessable_entity
  end
end
