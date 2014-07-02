Playlist.destroy_all
Question.destroy_all
User.destroy_all
Game.destroy_all

p1 = Playlist.create(:name => 'Favorite Rock', :genre => 'Rock')
p2 = Playlist.create(:name => 'Poppy Pop Music', :genre => 'Pop')

u1 = User.create(:username => 'fai.weiner@gmail.com', :avatar => 'http://png-1.findicons.com/files/icons/1072/face_avatars/300/i04.png', :password => 'password', :password_confirmation => 'password')
