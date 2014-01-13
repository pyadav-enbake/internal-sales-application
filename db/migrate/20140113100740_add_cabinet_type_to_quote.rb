class AddCabinetTypeToQuote < ActiveRecord::Migration
  def change
    add_column :quotes, :cabinet_type_id, :integer
    add_column :quotes, :countertop_design_id, :integer
  end
end
