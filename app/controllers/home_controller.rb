class HomeController < ClientController
  def index
	@products = Rcadmin::Product.all
  end
  def quick_quote
	@all_products = Rcadmin::Product.all
  end
  
  def aboutus
  end

  def contactus
	@contactus_details = Rcadmin::StaticPage.contactus
  end

  def aboutus
	@aboutus_details = Rcadmin::StaticPage.aboutus
  end

  def privacy_policy
	@privacy_policy_details = Rcadmin::StaticPage.privacy_policy
  end
  
  def mycart
   @cart_details = Hash.new
	if session[:cart]
		@cart_details = session[:cart]
	end
	@cart_details[params[:cart][:name]] = params[:cart] if params[:cart]
	
	session[:cart] = @cart_details
	
	@mycart_products = session[:cart].values 
	@mycart_products.delete_if {|x| x == nil } 
  end
  
  def clear_cart
   session[:cart][params[:id]] = nil
   redirect_to :action=>"mycart"
  end


  
end
