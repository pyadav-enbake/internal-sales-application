class CartsController < ClientController

  def mycart
   @cart_details = Hash.new
	if session[:cart]
		@cart_details = session[:cart]
	end
	if params[:cart]
		if @cart_details.size == 0
			@cart_details[params[:cart][:name]] = params[:cart] 
		else
			@nh = {}
			@cart_details.to_a.each do |k,v|
				if k == params[:cart][:name]
					@nh[:name] = params[:cart][:name]
					if !v.nil?
					
						@nh[:quantity]  =  v[:quantity].to_i + params[:cart][:quantity].to_i 
						@nh[:price]  =  v[:price].to_f + params[:cart][:price].to_f
					else
						@nh[:quantity]  =   params[:cart][:quantity]
						@nh[:price]  =  params[:cart][:price]
					end 
					@cart_details[params[:cart][:name]] = @nh
					
				else
					@cart_details[params[:cart][:name]] = params[:cart] 
				end
			end
			
		end
	end
	session[:cart] = @cart_details
	
	@mycart_products = session[:cart].values 
	@mycart_products.delete_if {|x| x == nil } 
	session[:cart_size] = @mycart_products.size
  end
  
  
  
  def update_cart
	@single_price = session[:cart][params['cart']['name']][:price].to_f/session[:cart][params['cart']['name']][:quantity].to_i
	@update_cart_info = Hash.new
	@update_cart_info[:name] = params['cart']['name']
	@update_cart_info[:price] = params['cart']['quantity'].to_i * @single_price
	@update_cart_info[:quantity] = params['cart']['quantity']
	session[:cart][params[:cart][:name]] = @update_cart_info
	redirect_to :action=>"mycart"
  end

  def clear_cart
   session[:cart][params[:id]] = nil
   redirect_to :action=>"mycart"
  end


end
