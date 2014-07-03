class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :authenticate_user
  before_action :save_login_state, :only => [:new, :login_attempt]

  RSpotify.authenticate("e3819ce718d6427488d4ff5e1a6da086", "f1427015700f4a41ad5ab1f6066a4be9")
  
  private

  def scoreboard
    # return list of users and scores that the partial can render
    @games_all = Game.where("total_time_points is not null").order("total_time_points desc").limit(10)
    # iteration happens in the partial view
  end

  def authenticate_user
    if session[:user_id].present? 
      @current_user = User.where(:id => session[:user_id]).first
    end

    if @current_user.nil?
      session[:user_id] = nil
    end
  end

  def save_login_state
    if session[:user_id].present?
      return false
    else
      return true
    end
  end

  def current_user
    @current_user ||= User.where(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
