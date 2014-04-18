class CreateProductTypeSelections < ActiveRecord::Migration
  def change
    create_table :product_type_selections do |t|
      t.references :product_type, index: true
      t.references :selection_type, index: true
      t.references :quote, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
