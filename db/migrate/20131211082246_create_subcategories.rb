class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.integer :category_id
      t.string :name
      t.integer :status,:limit=>1

      t.timestamps
    end
  end
end
