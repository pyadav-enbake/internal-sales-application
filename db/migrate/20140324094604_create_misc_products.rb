class CreateMiscProducts < ActiveRecord::Migration
  def change
    create_table :misc_products do |t|
      t.integer :quote_id
      t.string :title
      t.text :description
      t.float :price
      t.string :measurement_type
      t.string :customer_wording

      t.timestamps
    end
    add_index :misc_products, :quote_id
  end
end
