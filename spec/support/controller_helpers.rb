module ControllerHelpers
  def log_in_as(user)
    session[:user_id] = user.id
  end

end