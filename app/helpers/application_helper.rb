module ApplicationHelper
  def smartnav
    links = ''
    if @current_user.try(:is_admin)
      links += "<li>" + link_to('View users', users_path) + "</li>"
    end

    if @current_user.present?
      links += "<div><li class='nav-li'>"
      links += link_to('Logout', login_path, :data => {:method => :delete, :confirm => 'Really logout?'})
      links += "</li>"
      links += "<li class='nav-li'>"
      links += link_to(@current_user.username, users_path)
      links += "</li></div>"
    else
      links += "<div><li class='nav-li'>#{ link_to('Sign up', new_user_path) }</li></div>"
      links += "<div><li class='nav-li'>#{ link_to('Sign in', login_path) }</li></div>"
    end

    links
  end
end
