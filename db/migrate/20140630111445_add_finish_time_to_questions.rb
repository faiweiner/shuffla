class AddFinishTimeToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :finish_at, :datetime
  end
end
