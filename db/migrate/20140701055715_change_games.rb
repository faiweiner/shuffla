class ChangeGames < ActiveRecord::Migration
  def change
    change_column(:games, :total_time_points, :float)
  end
end
