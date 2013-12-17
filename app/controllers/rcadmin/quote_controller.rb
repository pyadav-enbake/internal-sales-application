class Rcadmin::QuoteController < ApplicationController
	def index
		session[:quote_id] = nil
		@quote = Rcadmin::Quote.new
	end

	def save_customer_deatils
		@quote = Rcadmin::Quote.new( params[:rcadmin_quote])
		if @quote.save
				session[:quote_id] = @quote.id
				redirect_to :action => 'show_category'
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
		@quote = Rcadmin::Quote.find(session[:quote_id] )
		@categories = @quote.category.split(',')
		@all_categories =  Rcadmin::Category.where(["id in (?)", @categories])
		@all_products =  Rcadmin::Product.where(["category_id in (?)", @categories])
		@all_subcategories =  Rcadmin::Subcategory.where(["category_id in (?)", @categories])
		
	end
	
	def send_quote
		if params[:product].size > 0
			@quote = Rcadmin::Quote.find(session[:quote_id] )
			@quote.delivery_date = params["extra_info"]['delivery_date']
			@quote.sales_closing_potential = params["extra_info"]['sales_closing_potential']
			@quote.status = 0
			@quote.save
			params[:product].each do |key,val|
				@quota_product = {}
				@quota_product['quote_id'] = session[:quote_id]
				@quota_product['product_id'] = key.to_i
				@quota_product['quantity'] = params['quantity'][key]
				@quota_product['total_price'] = params['tot_price'][key]
				@quota_product['status'] = 0
				if @quota_product['quantity'].to_i > 0
					@rcadmin_quota_product = Rcadmin::QuoteProduct.new(@quota_product) 
					@rcadmin_quota_product.save if params['quantity'][key] 
				end
			end
			@customer = Rcadmin::Customer.find(@quote.customer_id)
			#render :text => @quote.inspect and return false
			WelcomeMailer.send_quote_mail(@quote.customer_id).deliver
			WelcomeMailer.send_quote_mail_customer(@customer).deliver
		end
		render :text => 'ok'
		#redirect_to "/rcadmin/customers/#{@quote.customer_id}/edit"
	end
	
	def resend_quote
		@qid = params["quote_id"]
		@existquote = Rcadmin::Quote.find(@qid)
		@quote = Rcadmin::Quote.new
		@quote.customer_id = params["customer_id"]
		@quote.category = @existquote.category
		@quote.	status = @existquote.status
		@quote.delivery_date = @existquote.delivery_date
		@quote.sales_closing_potential = @existquote.sales_closing_potential
		if @quote.save
			params[:quantity].each do |key,val|
				@quota_product = {}
				@quota_product['quote_id'] = @quote.id
				@quota_product['product_id'] = key.to_i
				@product_details =  Rcadmin::Product.find(@quota_product['product_id'])
				@quota_product['quantity'] = val.to_i
				@quota_product['total_price'] = @product_details.price * @quota_product['quantity']
				@quota_product['status'] = 0
				if @quota_product['quantity'].to_i > 0
					@rcadmin_quota_product = Rcadmin::QuoteProduct.new(@quota_product) 
					@rcadmin_quota_product.save  
				end

				
			end
			@customer = Rcadmin::Customer.find(@quote.customer_id)
			#render :text => @quote.inspect and return false
			WelcomeMailer.send_quote_mail(@quote.customer_id).deliver
			WelcomeMailer.send_quote_mail_customer(@customer).deliver

			
		else
			render :text => 'Some thing went Wornge' and return false
		end
		redirect_to "/rcadmin/customers/#{@quote.customer_id}/edit"
		#render :text => params.inspect and return false
	
	end
  
end
