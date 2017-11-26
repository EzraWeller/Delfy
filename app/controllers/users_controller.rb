class UsersController < ApplicationController
  before_action :logged_in_user,       only: [:edit, :update, :index, :destroy]
  before_action :correct_user,         only: [:edit, :update]
  before_action :admin_user,           only: [:destroy, :index]

  def show
    @user = User.find(params[:id])
    @feed_owner = @user
    @community = Community.find_by(id: 1)
    @leadcommunities = Community.all.where(leader: @user.id)
  end

  def ideas
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated == true
    @ideas = @user.ideas.page(params[:page])
    @branches = @user.branch_ideas.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email and click activation the link that is sent to you."
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def index
    @users = User.where(activated: true).page(params[:page])
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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User deleted."
    redirect_back_or(root_url)
  end

  def search
    @users = User.search_users_for(params[:search]).page(params[:page])
    @community = Community.find(params[:community_id])
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