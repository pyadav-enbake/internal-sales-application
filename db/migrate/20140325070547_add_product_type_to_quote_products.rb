class AddProductTypeToQuoteProducts < ActiveRecord::Migration
  def change
    add_column :quote_products, :product_type, :string, default: 'Rcadmin::Product'
    add_index :quote_products, :product_type
    add_index :quote_products, :product_id
  end
end
