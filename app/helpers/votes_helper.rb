module VotesHelper
  def voted_on?(failing)
    if logged_in?
      failing.votes.where("user_id = ? OR voter_ip = ?", current_user.id, request.remote_ip).first
    else
      failing.votes.where(voter_ip: request.remote_ip).first
    end
  end
end
