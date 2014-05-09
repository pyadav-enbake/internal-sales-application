class AddMiscsToQuoteCategories < ActiveRecord::Migration
  def change
    add_column :quote_categories, :miscs, :hstore
  end
end
