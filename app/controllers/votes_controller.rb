class VotesController < ApplicationController
  def create
    @user = User.find_by_login! params[:login]
    @failing = @user.failings.find params[:failing_id]
    @vote = @failing.votes.new agree: !params[:agree].nil?
    @vote.user = current_user
    @vote.voter_ip = request.remote_ip
    @vote.save!

    xhr_message "thanks!"
  rescue ActiveRecord::RecordInvalid
    xhr_message "already voted"
  end

  private

  def xhr_message(message = "thanks!")
    render :update do |page|
      score = @failing.votes_score + (@vote.agree? ? 1 : -1)
      page[@failing].select(".toolbar").first.innerHTML = "<strong>#{score}</strong> votes | #{message}"
    end
  end
end
