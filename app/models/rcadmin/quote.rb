class Rcadmin::Quote < ActiveRecord::Base
	attr_accessible :customer_id,:category,:status,:delivery_date,:sales_closing_potential
	
	belongs_to :customer
	has_many :quote_product,dependent: :destroy
	
	#default_scope where(:status => 0)
	scope :find_by_customer, ->(customer_id) { where(:customer_id=>customer_id) }
end
