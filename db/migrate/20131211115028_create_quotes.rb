class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :customer_id
      t.string :category

      t.timestamps
    end
  end
end
