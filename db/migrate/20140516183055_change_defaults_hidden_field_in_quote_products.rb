class ChangeDefaultsHiddenFieldInQuoteProducts < ActiveRecord::Migration
  def up
    change_column_default :quote_products, :hidden, true
  end

  def down
    change_column_default :quote_products, :hidden, false
  end
end
