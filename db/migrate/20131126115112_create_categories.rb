class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.timestamps
      t.integer :status ,:limit => 1
      t.integer :quote_id,:default => 0
    end
  end
end
