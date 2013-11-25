class Rcadmin::DashboardController < ApplicationController
before_filter :check_auth
  def index
	#render :text => session['warden.user.admin.key'].inspect and return false;
  end
end
