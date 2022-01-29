class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: session_params[:email].downcase)
    if @user && @user.authenticate(session_params[:password])
      reset_session
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      log_in @user
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in? # Test for logged_in in the case of logging out a second time in a different browser
    redirect_to root_path
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
