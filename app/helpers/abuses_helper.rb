module AbusesHelper
  def reported?(failing)
    return false if App.optimized?
    user_id = current_user.id if logged_in?
    failing.abuses.where(user_id: user_id, token_id: @identity).first.present?
  end
end
