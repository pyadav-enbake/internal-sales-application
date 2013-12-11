class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :category_id
      t.integer :subcategory_id
      t.integer :dimension_id
      t.string :title
      t.text :description
      t.float :price
      t.integer :status,:limit=>1

      t.timestamps
    end
  end
end
