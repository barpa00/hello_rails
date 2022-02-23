class UsersController < ApplicationController
  def index
    @users = User.include(:missions)
  end
end
