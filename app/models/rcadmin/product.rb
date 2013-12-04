class Rcadmin::Product < ActiveRecord::Base
	validates_presence_of :category_id,:dimension_id,:name,:price
	attr_accessible :name,:price,:category_id,:dimension_id
	
	belongs_to :category 
	belongs_to :dimension
	
	scope :find_by_category, ->(category_id) { where(:category_id=>category_id) }
end
