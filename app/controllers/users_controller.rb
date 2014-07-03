class UsersController < ApplicationController

  before_action :check_if_logged_in, :except => [:new, :create]
  before_action :save_login_state, :only => [:new, :create]

  def new
    @user = User.new
  end
  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
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
    @user = @current_user
  end

  def show
    @user_avatar = find_current_user.avatar
    @user_creation = find_current_user.created_at.strftime("%B %d, %Y")
    @user_all_games = Game.find_by(user_id: @current_user.id)
    @user_games_count = find_current_user.games.count
    @user_points_all = find_current_user.games.sum('total_time_points')
    @user_highscore = find_current_user.games.maximum('total_time_points')
    @user_avgscore = find_current_user.games.average('total_time_points')
    @user_fastest = find_current_user.questions.minimum('duration')
    @user_fastest.round(2) if @user_fastest.present?
    @user_slowest = find_current_user.questions.maximum('duration')
    @user_slowest.round(2) if @user_slowest.present?
    @user_questions_count = find_current_user.questions.count
    @user_correct_count = find_current_user.games.sum('total_correct')
  end

  def update
    @user = @current_user
    @user.update(user_params)
    redirect_to user_path
  end

  def index
  end

  private

  def find_current_user
    User.find(@current_user.id)
  end
  def user_params
    params.require(:user).permit(:username, :name, :avatar, :password, :password_confirmation)
  end

  def check_if_logged_in
    redirect_to(root_path) if @current_user.nil?
  end
  
  def check_if_admin
    redirect_to(root_path) unless @current_user.is_admin?
  end
end