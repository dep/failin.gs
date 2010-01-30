class VotesController < ApplicationController
  def create
    @user = User.find_by_login! params[:login]
    @failing = @user.failings.find params[:failing_id]
    @vote = @failing.votes.new agree: !params[:agree].nil?
    @vote.save!

    render :update do |page|
      page[@failing].select(".toolbar").first.innerHTML = "<strong>#{@failing.votes_score}</strong> votes | thanks!"
    end
  end
end
