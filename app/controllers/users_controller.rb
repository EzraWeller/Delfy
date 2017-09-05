class UsersController < ApplicationController
  before_action :logged_in_user,       only: [:edit, :update, :index, :destroy]
  before_action :correct_user,         only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @community = Community.find_by(id: 1)
    @leadcommunities = Community.all.where(leader: @user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "New user created!"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def index
    @users = User.all
  end

  def ask_current_pw
    correct_old_password?(params[:user][:old_password])
  end

  def show_edit_form
    @user = User.find(params[:id])
  end

  def hide_edit_form
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User info saved!"
      redirect_to @user
    else
      flash[:danger] = "User info failed to update."
      redirect_to user_path(@user)
    end
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :old_password, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user == @user
    end

    def correct_old_password?(old_password)
      @user = User.find(params[:id])
      if @user.authenticate(old_password) == @user
      else
        redirect_to user_path(@user)
        flash[:danger] = "Incorrect current password."
      end 
    end

end