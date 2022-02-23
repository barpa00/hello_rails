class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.login(params[:user])
    if user
      session[:hellorails] = user.id
      redirect_to root_path, notice: I18n.t("user.log_in")
    else
      redirect_to "/users/log_in", notice: I18n.t("user.error")
    end
  end

  def destroy
    session[:hellorails] = nil
    redirect_to root_path, notice: I18n.t("user.log_out")
  end
end
