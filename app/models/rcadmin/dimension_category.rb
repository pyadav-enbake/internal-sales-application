class Rcadmin::DimensionCategory < ActiveRecord::Base
	validates_presence_of :name
	validates_inclusion_of :category_type, :in => %w(upper_cabintes base_cabintes)
	attr_accessible :name,:category_type
	has_many :dimensions,dependent: :destroy
end
