class CreateDimensionCategories < ActiveRecord::Migration
  def change
    create_table :dimension_categories do |t|
      t.string :name
     #t.column :category_type, "ENUM('upper_cabintes', 'base_cabinates')"

      t.timestamps
    end
    execute "ALTER TABLE dimension_categories add category_type ENUM('upper_cabintes', 'base_cabinates');"
  end
end
