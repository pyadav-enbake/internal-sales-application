class HomeController < ClientController
  def index
	@products = Rcadmin::Product.all
  end

  def quick_quote
	if params['rcadmin_product'] 
		if  params['rcadmin_product']['category_id']
			@category_id = params['rcadmin_product']['category_id']
			@all_products = Rcadmin::Product.find_by_category(@category_id)
		end 
	else
		@all_products = Rcadmin::Product.all
	end
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
  
  
  def help
  end
  
  def error404
	render :layout => 'nolayout'
  end
  
  


  
end
