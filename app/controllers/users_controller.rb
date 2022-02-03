# frozen_string_literal: true
class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  
  def
     show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  # Creates a new record of user from the new user form
  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user 
      flash[:success] = 'Welcome to the sample app'
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else 
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters

    # Confirms a logged in user
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in"
        redirect_to login_path
      end
    end
end
