class UpdatesToGames < ActiveRecord::Migration
  def change
    rename_column(:games, :genre, :genre_id)
    add_column(:games, :artist_id, :string)
    add_column(:games, :playlist_id, :integer)
  end
end
