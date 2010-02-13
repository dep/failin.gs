module VotesHelper
  def voted_on?(failing)
    return false if App.optimized?
    user_id = current_user.id if logged_in?
    failing.votes.where(user_id: user_id, token_id: @identity).first.present?
  end
end
