class DeleteColumnInQuestions < ActiveRecord::Migration
  def change
    remove_column(:questions, :artist_id)
    remove_column(:questions, :genre_id)
  end
end
