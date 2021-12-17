# frozen_string_literal: true
class UsersController < ApplicationController
  def show
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

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
