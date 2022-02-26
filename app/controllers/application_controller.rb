class ApplicationController < ActionController::Base
  before_action :basic, if: :production?
  helper_method :current_user

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  private
  def production?
    Rails.env.production?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:hellorails])
  end

  def after_sign_in_action(user, message)
    session[:hellorails] = user.id
    redirect_to root_path, notice: message
  end

  def basic
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['BASIC_AUTH_NAME'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def not_found
    render file: 'public/404.html',
           layout: false, 
           status: :not_found
  end
end
