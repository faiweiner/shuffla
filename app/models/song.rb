class Song < ActiveRecord::Base
  belongs_to :playlist
  has_one :question
end