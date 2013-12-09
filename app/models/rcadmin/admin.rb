class Rcadmin::Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	validates_presence_of :first_name,:last_name,:username
	#validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i , :message => "Invalid Format" 
	validates_uniqueness_of :email,:on => :create
	validates_presence_of :password ,:on => :create
	validates_confirmation_of :password_confirmation
	validates_acceptance_of :terms_and_conditions, :accept => true
   attr_accessible :first_name,:last_name,:email,:username, :password, :password_confirmation, :remember_me,:terms_and_conditions,:role
  #validates :username, :presence => true
	
	has_many :customers,dependent: :destroy
end
