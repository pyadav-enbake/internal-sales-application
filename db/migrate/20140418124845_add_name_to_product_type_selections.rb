class AddNameToProductTypeSelections < ActiveRecord::Migration
  def change
    add_column :product_type_selections, :name, :string, default: ''
  end
end
