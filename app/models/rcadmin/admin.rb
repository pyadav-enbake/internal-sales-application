class Rcadmin::Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
	validates_presence_of :first_name,:last_name,:username
	#validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i , :message => "Invalid Format" 
	validates_uniqueness_of :email,:on => :create
	validates_presence_of :password ,:on => :create
	validates_confirmation_of :password,:message => "Please retype your password below"
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me,:username,:first_name,:last_name
  #validates :username, :presence => true

end
