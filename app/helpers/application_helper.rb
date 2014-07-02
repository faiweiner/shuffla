module ApplicationHelper
  def smartnav
    links = ''
    links += shuffla
    links += " | "
    if @current_user.present?
      links += "<li>"
      links += link_to('Logout', login_path, :data => {:method => :delete, :confirm => 'Really logout?'})
      links += "</li>"
      links += " | "
      links += "<li>"
      links += link_to(@current_user.username, users_path)
      links += "</li>"
    else
      links += "<li>#{ link_to('Sign up', new_user_path) }</li>"
      links += " | "
      links += "<li>#{ link_to('Sign in', login_path) }</li>"
    end

    links
  end

  def shuffla
    "<li>#{ link_to('Shuffla', '/') }</li>"
  end
end
