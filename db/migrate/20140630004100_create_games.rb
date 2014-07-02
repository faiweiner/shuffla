class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :total_correct
      t.integer :total_time_points
      t.string :genre
      t.timestamps
    end
  end
end
