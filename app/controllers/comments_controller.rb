class CommentsController < ApplicationController
  def create
    @user = User.find_by_login! params[:login]
    @failing = @user.failings.find params[:failing_id]
    @comment = @failing.comments.new params[:comment]
    @comment.user_id = current_user.id
    @comment.submitter_ip = request.remote_ip

    if @comment.save
      respond_to do |format|
        format.html { redirect_to profile_url(@user) }
        format.js {
          render :update do |page|
            page.insert_html :bottom, dom_id(@failing, :comments), partial: @comment
            page[@comment].visual_effect :highlight
            page[@failing].select('.reply_wrapper').first.hide.select("form").first.reset
          end
        }
      end
    else
      respond_to do |format|
        format.html { render "failings#index" }
        format.js {
          render :update do |page|
            page.alert @comment.errors.full_messages.join(". ")
          end
        }
      end
    end
  end
end
