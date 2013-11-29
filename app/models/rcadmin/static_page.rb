class Rcadmin::StaticPage < ActiveRecord::Base
	validates_presence_of :name,:content
	attr_accessible :name,:content
	
	scope :contactus,->{ where(:name=>'contactus') }
	scope :aboutus,->{ where(:name=>'aboutus') }
	scope :privacy_policy,->{ where(:name=>'privacy policy') }
end
