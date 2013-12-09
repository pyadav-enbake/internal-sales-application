module ApplicationHelper
 def current_user
     @current_user ||= session[:admin_id] && @current_user = Rcadmin::Admin.find(session[:admin_id]) # Use find_by_id to get nil instead of an error if user doesn't exist
  end
  


end
