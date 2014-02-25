module ApplicationHelper
 def current_user
     @current_user ||= session[:admin_id] && @current_user = Rcadmin::Admin.find(session[:admin_id]) # Use find_by_id to get nil instead of an error if user doesn't exist
  end
  

 def with_markup total, markup
   markup_amount = total / 100 * markup
   total + markup_amount
 end

 def sections
   [
     {id: 1, name: 'Selection 1'}, {id: 2, name: 'Selection 2'},
     {id: 3, name: 'Selection 3'}, {id: 4, name: 'Selection 4'}
   ].map { |s| OpenStruct.new(s) }
 end


end
