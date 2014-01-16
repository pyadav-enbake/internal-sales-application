class AddFieldsToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :cabinet_types_info, :text
    add_column :quotes, :countertop_designs_info, :text
  end
end
