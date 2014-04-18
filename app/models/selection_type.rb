class SelectionType < ActiveRecord::Base
  belongs_to :selectable, polymorphic: true

  attr_protected :id
end
