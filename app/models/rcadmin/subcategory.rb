class Rcadmin::Subcategory < ActiveRecord::Base
  validates_presence_of :name,:status
  validates_uniqueness_of :name,:on => :create
  attr_accessible :name,:status

  #belongs_to :category 
  has_many :products, dependent: :destroy
  has_many :cabinet_products, dependent: :destroy
  has_many :laminate_products, dependent: :destroy
	
end
