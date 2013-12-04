class Rcadmin::EmailTemplate < ActiveRecord::Base
	validates_presence_of :template_name,:message_body
	attr_accessible :template_name,:message_body
end
