module SessionsHelper
  def current_user
    if session[:hellorails].present?
      @user ||= User.find_by(id: session[:hellorails])
    else
      nil
    end
  end
end
