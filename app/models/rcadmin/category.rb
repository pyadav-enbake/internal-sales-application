class Rcadmin::Category < ActiveRecord::Base
	validates_presence_of :name
	attr_accessible :name,:description,:status
end
