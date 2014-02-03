class Rcadmin::ContractorCategory < ActiveRecord::Base
  belongs_to :contractor
  belongs_to :category

  attr_accessible :contractor_id, :category_id
end
