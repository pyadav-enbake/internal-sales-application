class Rcadmin::FaqCategory < ActiveRecord::Base
	validates_presence_of :name,:description,:display_order,:status
	attr_accessible :name,:description,:display_order,:status
	has_many :products,dependent: :destroy
	

end
