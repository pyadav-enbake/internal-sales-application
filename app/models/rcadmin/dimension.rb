class Rcadmin::Dimension < ActiveRecord::Base
	attr_accessible :lower_range,:upper_range,:dimension_category_id
	belongs_to :dimension_category
end
