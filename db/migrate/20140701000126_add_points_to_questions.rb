class AddPointsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :points, :float
  end
end
