class AddTrackColumnToQuestions < ActiveRecord::Migration
  def change
    add_column(:questions, :track_uri, :string)
  end
end
