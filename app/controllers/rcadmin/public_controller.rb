class Rcadmin::PublicController < ApplicationController
  layout 'devise'
  def index
  end
  def destroy
	session.clear
	redirect_to :controller => 'devise/sessions', :action => 'new'
  end
end
