class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :basic, if: :production?

  private
  def production?   
    Rails.env.production?
  end

  def basic
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['BASIC_AUTH_NAME'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
