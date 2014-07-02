class UsersController < ApplicationController

  before_action :check_if_logged_in, :except => [:new, :create]
  before_action :save_login_state, :only => [:new, :create]

  def new
    @user = User.new
  end
  def create
    @user = User.new user_params
    if @user.save
      flash[:notice] = "You've successfully signed up."
      # Once someone signs up, they currently need to log in. Better to have automatically log-in?
      flash[:color] = "valid"
      redirect_to root_path
    else
      flash[:notice] = "Unsuccessful sign up, please try again."
      flash[:color] = "invalid"
      render :new
    end
  end

  def edit
    render :text => 'This is the user edit page. Imagine there is a form here.'
  end

  def index
    @user_all_games = Game.find_by(user_id: @current_user.id)
    @user_games_count = User.find(@current_user.id).games.count
    @user_points_all = User.find(@current_user.id).games.sum('total_time_points')
    @user_questions_count = User.find(@current_user.id).questions.count
    @user_correct_count = User.find(@current_user.id).games.sum('total_correct')
  end

  private

  def user_params
    params.require(:user).permit(:username, :avatar, :password, :password_confirmation)
  end

  def check_if_logged_in
    redirect_to(root_path) if @current_user.nil?
  end
  
  def check_if_admin
    redirect_to(root_path) unless @current_user.is_admin?
  end
end