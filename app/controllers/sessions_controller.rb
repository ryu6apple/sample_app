class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      # debugger
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      flash[:success] = "Log in!"
      redirect_to user_url(@user) 
    else
      flash.now[:danger] = "invalid email / password combination"
      render 'new'
    end
    
  end

  def destroy
    log_out if logged_in?
    # debugger
    # flash[:info] = "logout"
    redirect_to root_url
  end
end
