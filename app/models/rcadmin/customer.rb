class Rcadmin::Customer < ActiveRecord::Base
	validates_presence_of :contractor_id,:first_name,:last_name,:email
	validates :email, :presence => true, :email => true
	validates_uniqueness_of :email,:on => :create
	validates_presence_of :state,:city,:address,:zip
	validates_format_of :zip, :with => /^([0-9]){5}(-([0-9]){4})?$/,:multiline => true, :message => "should be in the form 12345 or 12345-1234"
	validates_presence_of:phone,:status
	validates :phone, :length => {:minimum => 6, :maximum => 25}, :format => { :with => /\A\S[0-9\+\/\(\)\s\-]*\z/i }
	
	attr_accessible :contractor_id,:first_name,:last_name,:email,:state,:city,:address,:zip,:phone,:status

	belongs_to :contractor
	has_many :quotes,dependent: :destroy
	scope :default, -> {  where(:status => 0)  }
	#composed_of :name, :mapping => %w(first_name last_name)
	scope :by_contractor, ->(contractor_id) { where(contractor_id: contractor_id) }
	def fullname
	  "#{self.first_name+' '+self.last_name}"
	end

end
