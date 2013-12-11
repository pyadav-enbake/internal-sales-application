class Rcadmin::Product < ActiveRecord::Base
	validates_presence_of :subcategory_id,:title,:price,:status
	attr_accessible :title,:price,:subcategory_id,:description,:status
	
	belongs_to :subcategory 
	
	#scope :find_by_category, ->(category_id) { where(:category_id=>category_id) }
end
