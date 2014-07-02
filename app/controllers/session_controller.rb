class SessionController < ApplicationController
  def new
    #Loginform
  end
  def login_attempt
    user = User.find_by(:username => params[:username])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back! You are logged in as #{user.username}"
      redirect_to games_path
    else
      flash[:notice] = "Invalid login. Please try again."
      redirect_to login_path
    end
  end
  
  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
