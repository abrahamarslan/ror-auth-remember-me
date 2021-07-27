class UserController < ApplicationController
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

end
