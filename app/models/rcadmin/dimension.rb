class Rcadmin::Dimension < ActiveRecord::Base
	 validates_presence_of :dimension_category_id,:lower_range
	 validates :lower_range, numericality: true
	 validate :upper_range_valid
	 attr_accessible :lower_range,:upper_range,:dimension_category_id
	 
	belongs_to :dimension_category 
	has_many :products,dependent: :destroy

	
	
	def fullrange
		if(upper_range == nil)
			'Range '+lower_range.to_s 
		else
			'Range '+lower_range.to_s + ' to ' + upper_range.to_s
		end
	end
	def upper_range_valid
		if(upper_range)
			if(upper_range < lower_range)
				errors.add(:base, "Upper range should greater than lower range")
			end
		end
	end
	
end
