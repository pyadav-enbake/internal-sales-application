class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :name, default: ""
      t.string :type, default: "", null: false

      t.timestamps
    end
    add_index :product_types, :type
  end
end
