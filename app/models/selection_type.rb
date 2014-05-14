class SelectionType < ActiveRecord::Base
  belongs_to :selectable, polymorphic: true

  attr_protected :id

  def to_s; self.name; end
end
