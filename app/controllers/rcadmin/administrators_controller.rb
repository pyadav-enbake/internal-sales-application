class Rcadmin::AdministratorsController < ApplicationController
  before_filter :check_auth
  def index
	flash[:notice] = nil
	@administrators =  Rcadmin::Admin.all
  end

  def new
	@administrator =  Rcadmin::Admin.new
  end

  def create
  
	@administrator =  Rcadmin::Admin.new(params[:rcadmin_admin])
	if @administrator.save
	render :text => 'in' and return false
		flash[:notice] = 'Record added successfully.'
		redirect_to  :controller => "rcadmin/administrators",:action => "index"
	else
	#render :text => @administrator.errors.full_messages and return false
		render :action => "new"
	end
  end
  
  def edit
	 @administrator = Rcadmin::Admin.find(params[:id])
  end

  def update
		@administrator = Rcadmin::Admin.find(params[:id])
		if @administrator.update_attributes(params[:rcadmin_admin])
			flash[:notice] = 'Record updated successfully.'
			redirect_to :action => "index"
		else
			render :action => "edit"
		end  
  end

  def destroy
		@administrator = Rcadmin::Admin.find(params[:id])
		@administrator.destroy
		flash[:notice] = 'Record deleted successfully.'
		redirect_to :action => "index"
  
  end
  
end
