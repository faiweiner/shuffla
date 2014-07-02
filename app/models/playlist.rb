# == Schema Information
#
# Table name: playlists
#
#  id    :integer          not null, primary key
#  name  :string(255)
#  genre :string(255)
#

class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :songs
end
