class Rcadmin::Category < ActiveRecord::Base
	validates_presence_of :name
	attr_accessible :name,:description,:status
	
	has_many :subcategories,dependent: :destroy
end
