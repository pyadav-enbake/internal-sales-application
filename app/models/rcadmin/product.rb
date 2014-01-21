class Rcadmin::Product < ActiveRecord::Base
	validates_presence_of :subcategory_id,:title,:price,:measurement_type,:status
	attr_accessible :subcategory_id,:title,:measurement_type,:price,:description,:status
	
	belongs_to :subcategory 
	#belongs_to :category 
	has_many :quote_product,dependent: :destroy
	
	#scope :find_by_category, ->(category_id) { where(:category_id=>category_id) }
end
