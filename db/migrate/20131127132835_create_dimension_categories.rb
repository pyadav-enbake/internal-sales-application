class CreateDimensionCategories < ActiveRecord::Migration
  def change
    create_table :dimension_categories do |t|
      t.string :name
     #t.column :category_type, "ENUM('upper_cabintes', 'base_cabinates')"
	  t.integer :category_type ,:limit => 1
      t.timestamps
    end
    
  end
end
