class Rcadmin::QuoteController < ApplicationController
	def index
	session[:quote_id] = nil
	@rcadmin_customer = Rcadmin::Customer.new
	end

	def save_customer_deatils
	
		@rcadmin_customer = Rcadmin::Customer.new(params[:rcadmin_customer])
		
		if @rcadmin_customer.save
			@quote = Rcadmin::Quote.new
			@quote.customer_id = @rcadmin_customer.id
			
			if @quote.save
			
				session[:quote_id] = @quote.id
				redirect_to :action => 'show_category'
			end
		else
		render :action=> 'index'
		end
		
	end
	
	

	def show_category
		if session[:quote_id] != nil
			@quote = Rcadmin::Quote.find(session[:quote_id] )
			@selected_category = @quote.category.split(',') if !@quote.category.nil?
		else
			@selected_category = []
		end
		
	end
	
	def save_category_deatils
			params["quote"]["category"].reject!{|a| a==""} 
		if params[:quote][:category].nil? or params["quote"]["category"].blank?
			flash[:error] = 'Please select any category'
			render :action => 'show_category'
		else
			@quote = Rcadmin::Quote.find(session[:quote_id] )
			params[:quote][:category] = params[:quote][:category].join(',')
			@quote.category = params[:quote][:category]
			if @quote.save
				redirect_to :action => 'show_product'
			end
		end		
	end
	
	def show_product
	#render :text => 'call' and return false
		@quote = Rcadmin::Quote.find(session[:quote_id] )
		@categories = @quote.category.split(',')
		@all_categories =  Rcadmin::Category.where(["id in (?)", @categories])
		@all_products =  Rcadmin::Product.where(["category_id in (?)", @categories])
		@all_subcategories =  Rcadmin::Subcategory.where(["category_id in (?)", @categories])
		
		#render :text => @all_subcategories.inspect and return false
	end
  
end
