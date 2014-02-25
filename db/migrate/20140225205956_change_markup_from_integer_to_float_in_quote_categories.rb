class ChangeMarkupFromIntegerToFloatInQuoteCategories < ActiveRecord::Migration
  def up
    change_column :quote_categories, :markup, :decimal, precision: 4, scale: 2, default: 0.0
  end

  def down
    change_column :quote_categories, :markup, :integer, default: 0
  end
end
