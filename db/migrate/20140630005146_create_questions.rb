class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.boolean :correct
      t.timestamps :q_start_time
      t.timestamps :q_stop_time
      t.string :artist_id
      t.string :genre_id 
    end
  end
end
