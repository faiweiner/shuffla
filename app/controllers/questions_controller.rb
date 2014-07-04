class QuestionsController < ApplicationController
  def new

    game_length = 5

    ####### DETERMINE GAME LENGTH ABOVE!!! #######

    if @current_user.games.count > 0 && @current_user.games.last.questions.count >= game_length
      @game_id = @current_user.games.last.id # pull Game ID for the following view to pull up statistics
      redirect_to game_path(id:@game_id)
    else
      @game = Game.where(:user_id => @current_user.id).last

      @selected_artist = RSpotify::Artist.find(@game.artist_id)
      @selected_artist_uri = @selected_artist.uri.gsub!('spotify:artist:','')

      @tracks_array = @selected_artist.top_tracks(:US)

      #check how many songs are on the tracks_array
      # if @tracks_array.count > 10
      
      #### DUPLICATE CHECKER

      previous_tracks = @game.questions.map { |question| question.track_uri }
      previous_tracks.each do |uri|
        uri.gsub!('spotify:track:','')
      end

      # Selecting songs for the picker
      @choices_tracks = []
      @choices_tracks = @tracks_array.sample(4)
      @selected_track = @choices_tracks.sample


      while previous_tracks.include? @selected_track.id
        @selected_track = @choices_tracks.sample
      end
      
      @question = Question.new
      @question.track_uri = @selected_track.id
      @question.save

      @question_id = @question.id # Pass current object's ID into an instance variable to be accessible in the Create view
    end
  end

  def create 
    @question = Question.find params[:question_id]
    @question.game_id = params[:game_id]
    @question.finish_at = Time.now
    if params[:answer_selection] == params[:answer]
      @question.correct = true 
    else
      @question.correct = false 
    end
    @question.duration = @question.finish_at - @question.created_at
    @question.save

    redirect_to new_question_path
  end

  private

  def question_params
    params.require(:question).permit(:correct, :artist_id, :finish_at)
  end

  def prefix_chopper(uri)
    uri.gsub!('spotify:track:','')
  end
end