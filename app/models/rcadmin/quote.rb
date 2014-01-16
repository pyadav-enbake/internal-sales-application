class Rcadmin::Quote < ActiveRecord::Base
	validates_presence_of :contractor_id,:customer_id
	attr_accessible :contractor_id,:customer_id,:category,:status,:delivery_date,:sales_closing_potential
	
	belongs_to :contractor
	has_many :quote_product,dependent: :destroy
	belongs_to :cabinet_type
	belongs_to :countertop_design
	
	
	#default_scope where(:status => 0)
	scope :find_by_customer, ->(customer_id) { where(:customer_id=>customer_id) }
end
