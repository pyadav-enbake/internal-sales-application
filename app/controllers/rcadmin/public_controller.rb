class Rcadmin::PublicController < ApplicationController

  layout 'devise'
  def index
  end
  def destroy
	@admin =  Rcadmin::LoginLog.find(session[:login_log_id])
	@admin.logout_time= Time.now
	@admin.save
	session.clear
	redirect_to :controller => 'devise/sessions', :action => 'new'
  end
end
