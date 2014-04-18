class CabinetType < ProductType
  has_many :selections, as: :selectable, class_name: 'SelectionType'
  attr_protected :id
end
