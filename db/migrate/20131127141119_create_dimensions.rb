class CreateDimensions < ActiveRecord::Migration
  def change
    create_table :dimensions do |t|
      t.integer :dimension_category_id
      t.float :lower_range
      t.float :upper_range

      t.timestamps
    end
  end
end
