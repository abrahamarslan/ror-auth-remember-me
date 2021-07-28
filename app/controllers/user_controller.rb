class UserController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :authorized_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      #Handle successful update
      flash[:success] = "Profile successfully updated."
      redirect_to @user
    else
      #Error message
      flash[:danger] = "Some error occurred in updating the user."
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  #Before filters
  #
  #Confirms a logged-in user
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "You must be logged in to visit this page"
      redirect_to login_url
    end
  end

  #Is authorized user
  def authorized_user
    @user = User.find(params[:id])
    #redirect_to(root_url) unless @user == current_user
    redirect_to(root_url) unless current_user?(@user)
  end


end
