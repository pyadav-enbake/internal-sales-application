class AddTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :type, :string, default: "", null: false
  end
end
