class Rcadmin::Faq < ActiveRecord::Base
	validates_presence_of :faq_category_id,:question,:answer,:display_order,:status
	attr_accessible :faq_category_id,:question,:answer,:display_order,:status
	belongs_to :faq_category 
end
