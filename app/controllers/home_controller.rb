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
  
  
  def help
  end
  
  


  
end
