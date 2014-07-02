class ChangeQuestions < ActiveRecord::Migration
  def change
    rename_column(:questions, :points, :duration)
  end
end
