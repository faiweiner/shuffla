# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  avatar          :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base

  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, :presence => true, :uniqueness => true, :length => { :minimum => 2, }
  validates_format_of :username, :with => EmailRegex
  # validates :password_digest, length: { in: 6..20 }
  has_secure_password
  has_many :games
  has_many :playlists
  has_many :questions, through: :games
end
