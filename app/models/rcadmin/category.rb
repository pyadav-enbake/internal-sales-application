class Rcadmin::Category < ActiveRecord::Base
  validates_presence_of :name
  attr_accessible :name,:description,:status,:quote_id

  scope :default, -> {  where(:quote_id => 0)  }

  #has_many :subcategories, dependent: :destroy
  #has_many :products, dependent: :destroy
end
