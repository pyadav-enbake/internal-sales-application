class AddTitleToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :title, :string
  end
end
