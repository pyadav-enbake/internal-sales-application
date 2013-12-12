class Rcadmin::Customer < ActiveRecord::Base
	validates_presence_of :admin_id,:first_name,:last_name,:email,:state,:city,:address,:zip,,:phone,:status
	attr_accessible :admin_id,:first_name,:last_name,:email,:state,:city,:address,:zip,,:phone,:status
	
	belongs_to :admin
	scope :default, -> {  where(:status => 0)  }
	
end
