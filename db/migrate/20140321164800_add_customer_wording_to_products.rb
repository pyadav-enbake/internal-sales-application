class AddCustomerWordingToProducts < ActiveRecord::Migration
  def change
    add_column :products, :customer_wording, :string, default: ""
  end
end
