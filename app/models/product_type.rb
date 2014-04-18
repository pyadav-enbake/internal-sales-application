class ProductType < ActiveRecord::Base

  has_many :selections, as: :selectable, class_name: 'SelectionType'
end
