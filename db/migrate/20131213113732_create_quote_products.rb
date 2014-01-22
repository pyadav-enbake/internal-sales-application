class CreateQuoteProducts < ActiveRecord::Migration
  def change
    create_table :quote_products do |t|
      t.integer :quote_id
      t.integer :product_id
      t.integer :category_id
      t.integer :quantity
      t.float   :total_price, :precision => 10, :scale => 2
      t.integer :status,:limit =>1
      t.string :header_option,:default =>'No'

      t.timestamps
    end
  end
end
