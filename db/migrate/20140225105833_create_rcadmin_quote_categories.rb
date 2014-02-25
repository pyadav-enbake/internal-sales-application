class CreateRcadminQuoteCategories < ActiveRecord::Migration
  def change
    create_table :quote_categories do |t|
      t.references :quote, index: true
      t.references :category, index: true
      t.integer :markup, default: 0

      t.timestamps
    end
  end
end
