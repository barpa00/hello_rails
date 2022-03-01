class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.login(params[:user])
    if user
      after_sign_in_action(user, I18n.t("user.log_in"))
    else
      redirect_to log_in_path, notice: I18n.t("user.error")
    end
  end

  def destroy
    session[:hellorails] = nil
    redirect_to log_in_path, notice: I18n.t("user.log_out")
  end
end
