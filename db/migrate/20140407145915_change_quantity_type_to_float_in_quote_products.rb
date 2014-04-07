class ChangeQuantityTypeToFloatInQuoteProducts < ActiveRecord::Migration
  def up
    change_column :quote_products, :quantity, :float, default: 0.0
  end

  def down
    change_column :quote_products, :quantity, :integer, default: 0
  end
end
