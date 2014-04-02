class ChangeColumnTypeToIntegerType < ActiveRecord::Migration
  def up
    remove_column :products, :type
    add_column :products, :types_masking, :integer, default: 0
  end

  def down
    remove_column :products, :types_masking, :string, default: ""
    add_column :products, :type, :string
  end
end
