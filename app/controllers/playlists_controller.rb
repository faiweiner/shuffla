class PlaylistController < ApplicationController
  def index
    @playlists = Playlist.all
  end
end