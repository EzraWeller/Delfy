class UsersController < ApplicationController
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

end
