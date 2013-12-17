class AddMeasurementTypeToProduct < ActiveRecord::Migration
  def change
	add_column :products, :measurement_type, :string
  end
end
