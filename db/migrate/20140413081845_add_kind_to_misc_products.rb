class AddKindToMiscProducts < ActiveRecord::Migration
  def change
    add_column :misc_products, :kind, :string
  end
end
