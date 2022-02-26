class  Admin::UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy, :show]

  def index
    if current_user.admin? 
      @users = User.includes(:missions)
    else
      redirect_to root_path, notice: "權限不足訊息無法存取"
    end
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'success'
    else
      redirect_to admin_users_path, notice: 'not working'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :roles)
  end

  def find_user
    begin 
      @user = User.find_by!(id: params[:id])
    rescue  
      raise ActiveRecord::RecordNotFound
    end
  end 
end
