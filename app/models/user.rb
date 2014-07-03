# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  username         :string(255)
#  avatar           :string(255)
#  password_digest  :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  oauth_token      :string(255)
#  oauth_expires_at :datetime
#  name             :string(255)
#

class User < ActiveRecord::Base

  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, :presence => true, :uniqueness => true, :length => { :minimum => 10 }, :on => :create
  validates_format_of :username, :with => EmailRegex
  validates :name, :presence => true, :uniqueness => true, :length => { :minimum => 10 }, :on => :create
  # validates :password_digest, length: { in: 6..20 }
  has_secure_password
  has_many :games
  has_many :playlists
  has_many :questions, through: :games

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  
end
