class Rcadmin::CabinetType < ActiveRecord::Base
  attr_accessible :name,:status
  validates_presence_of :name,:status
  
  has_one :quote
  scope :default, -> {  where(:status => 0)  }
end
