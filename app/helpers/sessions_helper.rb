module SessionsHelper
  def current_user
    if session[:hellorails].present?
      @current_user ||= User.find(session[:hellorails])
    else
      nil
    end
  end
end
