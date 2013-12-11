class Rcadmin::QuoteController < ApplicationController
	def index
	@rcadmin_customer = Rcadmin::Customer.new
	end

	def save_customer_deatils
	#render :text => params.inspect and return false
		@rcadmin_customer = Rcadmin::Customer.new(params[:rcadmin_customer])
		if @rcadmin_customer.save
			@quote = Rcadmin::Quote.new
			@quote.customer_id = @rcadmin_customer.id
			
			if @quote.save
				session[:quote_id] = @quote.id
				redirect_to :action => 'show_category'
			end
		else
		end
		
	end
	
	

	def show_category

	#render :text => params.inspect and return false
		
	end
	
	def save_category_deatils
		@quote = Rcadmin::Quote.find(session[:quote_id] )
		params["quote"]["category"].reject!{|a| a==""} 
		params[:quote][:category] = params[:quote][:category].join(',')
		@quote.category = params[:quote][:category]
		if @quote.save
			redirect_to :action => 'show_product'
		end
		
	end
	
	def show_product
		@quote = Rcadmin::Quote.find(session[:quote_id] )
		@categories = @quote.category.split(',')
		
		@all_products =  Rcadmin::Product.where(["category_id in (?)", @categories])
		@all_subcategories =  Rcadmin::Subcategory.where(["category_id in (?)", @categories])
		
		#render :text => @all_subcategories.inspect and return false
	end
  
end
