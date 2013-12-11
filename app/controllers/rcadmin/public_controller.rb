class Rcadmin::PublicController < ApplicationController
  layout :resolve_layout
  def index
  end
  def destroy
	@admin =  Rcadmin::LoginLog.find(session[:login_log_id])
	@admin.logout_time= Time.now
	@admin.save
	session.clear
	render :text=> 'asdasda'.inspect and return false
	redirect_to :controller => 'devise/sessions', :action => 'new'
  end
  
  def category_dimension_name
	@rcadmin_dimension_categories =  Rcadmin::DimensionCategory.where("category_type=?",params[:val])
	respond_to do |format|
	  format.html {}
	end  
  end

  def dc_name
	@dimension_categories =  Rcadmin::DimensionCategory.where("category_type=?",params[:val])
	#render :text => @dimension_categories.inspect and return false
	respond_to do |format|
	  format.html {}
	end  
  end

  def subcat
	@sub_categories =  Rcadmin::Subcategory.where("category_id=?",params[:cat_id])
	#render :text => @dimension_categories.inspect and return false
	respond_to do |format|
	  format.html {}
	end  
  end
  
  
  private
  def resolve_layout
    case action_name
    when 'index'
      'devise'
    else
      'nolayout'
    end
  end

  
end
