class Rcadmin::Dimension < ActiveRecord::Base
	#attr_accessible :lower_range,:upper_range
	 validates_presence_of :dimension_category_id,:lower_range
	 validates :lower_range, numericality: true
	 attr_accessible :lower_range,:upper_range,:dimension_category_id
	 
	belongs_to :dimension_category 
	has_many :products,dependent: :destroy
	
	def fullrange
		if(upper_range == 0)
			'Range '+lower_range.to_s 
		else
			'Range '+lower_range.to_s + ' to ' + upper_range.to_s
		end
	end
end
