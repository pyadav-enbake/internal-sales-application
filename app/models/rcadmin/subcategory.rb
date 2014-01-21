class Rcadmin::Subcategory < ActiveRecord::Base
	validates_presence_of :category_id,:name,:status
	attr_accessible :category_id,:name,:status
	
	belongs_to :category 
	#has_many :products,dependent: :destroy
	
end
