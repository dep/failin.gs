module AbusesHelper
  def reported?(failing)
    if logged_in?
      failing.abuses.where("user_id = ? OR reporter_ip = ?", current_user.id, request.remote_ip).first
    else
      failing.abuses.where(reporter_ip: request.remote_ip).first
    end
  end
end
