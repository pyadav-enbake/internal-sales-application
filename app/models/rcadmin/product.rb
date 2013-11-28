class Rcadmin::Product < ActiveRecord::Base
	validates_presence_of :category_id,:dimension_id,:name,:price
	attr_accessible :name,:price,:category_id,:dimension_id
	
	belongs_to :category 
	belongs_to :dimension
	
end
