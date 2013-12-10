class Rcadmin::AdministratorsController < ApplicationController
  before_filter :check_auth,:authenticate
  def index
	flash[:notice] = nil
	@administrators =  Rcadmin::Admin.all
  end

  def new
	@administrator =  Rcadmin::Admin.new
  end

  def create
	@administrator =  Rcadmin::Admin.new(params[:rcadmin_admin])
	@administrator.terms_and_conditions = 1
	if @administrator.save
		flash[:notice] = 'Record added successfully.'
		redirect_to  :controller => "rcadmin/administrators",:action => "index"
	else
		render :action => "new"
	end
  end
  
  def edit
	 @administrator = Rcadmin::Admin.find(params[:id])
  end

  def update
		
		#if params[:rcadmin_admin][:quote_category]
		#	params["rcadmin_admin"]["quote_category"].reject!{|a| a==""} 
		#	params[:rcadmin_admin][:quote_category] = params[:rcadmin_admin][:quote_category].join(',')
		#end
		#render :text =>params[:rcadmin_admin].inspect and return false
		@administrator = Rcadmin::Admin.find(params[:id])
		if(params[:rcadmin_admin][:password] == "" && params[:rcadmin_admin][:password_confirmation] == "")
			params[:rcadmin_admin].delete('password')
			params[:rcadmin_admin].delete('password_confirmation')
		end
		if @administrator.update_attributes(params[:rcadmin_admin])
		   sign_in(@administrator, :bypass => true) 
			flash[:notice] = 'Record updated successfully.'
			if(@administrator.role == 'sales_admin')
				redirect_to "/rcadmin/administrators/#{@administrator.id}/edit"
			else
				redirect_to :action => "index"
			end
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
