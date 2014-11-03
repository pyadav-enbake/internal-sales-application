class AddPriceToQuoteProducts < ActiveRecord::Migration
  def change
    add_column :quote_products, :quote_price, :float, default: 0.0
  end
end
