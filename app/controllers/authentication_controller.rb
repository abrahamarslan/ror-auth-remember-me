class AuthenticationController < ApplicationController
  def login

  end

  def postLogin
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      #log the user in
      log_in user
      redirect_back_or user
    else
      #Error message
      flash[:danger] = "Invalid email/password combination."
      render 'login'
    end
  end

  def signup

  end

  def postSignup
    @user = User.new(user_params)
    if @user.save
      #Succesfully saved
      log_in @user
      flash[:success] = "Welcome to your dashboard!"
      redirect_to @user
    else
      #Error - redirect_back(fallback_location: root_path)
      render :action => 'signup'
    end
  end

  def logout
    log_out
    redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
