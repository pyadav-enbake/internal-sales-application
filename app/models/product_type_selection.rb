class ProductTypeSelection < ActiveRecord::Base
  belongs_to :product_type
  belongs_to :selection_type
  belongs_to :quote, class_name: 'Rcadmin::Quote'
  belongs_to :category, class_name: 'Rcadmin::Category'

  attr_protected :id
end
