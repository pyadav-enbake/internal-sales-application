class AddKindToProducts < ActiveRecord::Migration
  def change
    add_column :products, :kind, :string, default: 'CabinetProduct'
  end
end
