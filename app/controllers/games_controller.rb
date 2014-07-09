  class GamesController < ApplicationController
  def new
  end

  def index
    @games_all = Game.top_ten
  end
  def create
    # CHANGE POPULARITY SCORE HERE to narrow or widen search criteria
    popularity_selection = 50

    if params[:search].nil? || params[:search].empty? 
      flash[:notice] = "Please select an artist."
      redirect_to games_new_artist_path and return
    end

    # ::::ARTIST:::: if user come from ARTIST SEARCH (params) =>
    if params[:type] == 'artist'
      @artists = RSpotify::Artist.search(params[:search])
      # Next 10 lines check whether the artist is valid, based on Spotify's popularity score
      popularity_array = []

      @artists.each.with_index do |artist|
        popularity_array << artist.popularity
      end

      @wanted_artist_index = popularity_array.find_index{|value| value >= popularity_selection }

      if @wanted_artist_index.nil?
        flash[:notice] = "The selected artist cannot be selected due to regional copyrights or low ranking. Please try another artist."
        redirect_to games_new_artist_path and return 
      end

      @selected_artist = @artists.first
      @selected_artist_uri = @selected_artist.uri.gsub!('spotify:artist:','')

    # ::::GENERE:::: if user come from GENRE SEARCH (params) =>
    elsif params[:type] == 'genre'

    # ::::PLAYLIST:::: if user come from PLAYLIST SEARCH (params) =>
    elsif params[:type] == 'playlist'

    end

    @game = Game.new
    # Come back here to fix BUG - what if user drops out mid-game?
    @game.user_id = @current_user.id
    @game.artist_id = @selected_artist_uri
    @game.save

    redirect_to new_question_path
  end

  def genre
  end
  def playlist
  end
  def artist
  end

  def show
    @game = @current_user.games.last
    @game_questions = @game.questions
    artist_id = @game.artist_id
    @artist_test_name = RSpotify::Artist.find(artist_id).name
    @game_question_count = @current_user.games.last.questions.count
    @game_correct_count = @current_user.games.last.questions.where("correct = true").count
    @game.total_correct = @game_correct_count
    @game.save
    
    @bonus_points = 0
    @current_user.games.last.questions.each do |question|
      @bonus_points += 2 if ( question.correct && question.duration < 5 )
      @bonus_points += 1 if ( question.correct && question.duration < 10 )
    end

    ## points calculation ##

    @game_avg_time = @current_user.games.last.questions.average("duration")
    @game_pts_correct_answer = (@game_correct_count * 10)

    @game.total_time_points = @game_pts_correct_answer + @bonus_points

    @game.save
  end

  private

  def game_params
    params.require(:game).permit(:total_correct, :total_time_points, :genre, :user_id)
  end

end