# == Schema Information
#
# Table name: games
#
#  id                :integer          not null, primary key
#  total_correct     :integer
#  total_time_points :float
#  genre_id          :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#  artist_id         :string(255)
#  playlist_id       :integer
#

class Game < ActiveRecord::Base
  belongs_to :user
  has_many :questions
end
