class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    # debugger
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    # debugger
  end

  def create
    # debugger
    @user = User.create(user_params)
    if @user.save
      flash[:success] = "account created! welcome to the sample app"
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def edit
  end



  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
