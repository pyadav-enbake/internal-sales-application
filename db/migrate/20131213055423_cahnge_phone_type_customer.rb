class CahngePhoneTypeCustomer < ActiveRecord::Migration
  def change
	change_column :customers, :phone,:integer, :limit => 8
  end
end
