class VotesController < ApplicationController
  def create
    @user = User.find_by_login! params[:login]
    @failing = @user.failings.find params[:failing_id]
    @vote = @failing.votes.new agree: !params[:agree].nil?

    render :update do |page|
      page << <<JS
$("#{dom_id @failing}").select(".toolbar")[0].innerHTML = "<strong>#{@failing.votes.positive.count}</strong> votes | thanks!";
JS
    end
  end
end
