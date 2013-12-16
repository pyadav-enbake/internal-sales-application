class Rcadmin::Product < ActiveRecord::Base
	validates_presence_of :category_id,:subcategory_id,:title,:price,:status
	attr_accessible :title,:price,:subcategory_id,:description,:status,:category_id
	
	belongs_to :subcategory 
	belongs_to :category 
	has_many :quote_product,dependent: :destroy
	
	#scope :find_by_category, ->(category_id) { where(:category_id=>category_id) }
end
