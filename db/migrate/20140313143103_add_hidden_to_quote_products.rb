class AddHiddenToQuoteProducts < ActiveRecord::Migration
  def change
    add_column :quote_products, :hidden, :boolean, default: false
  end
end
