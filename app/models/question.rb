# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  correct    :boolean
#  created_at :datetime
#  updated_at :datetime
#  finish_at  :datetime
#  duration   :float
#  game_id    :integer
#

class Question < ActiveRecord::Base
  belongs_to :game
  has_one :song
end
