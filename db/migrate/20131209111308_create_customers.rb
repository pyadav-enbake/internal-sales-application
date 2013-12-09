class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
	  t.integer :admin_id
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :email
      t.integer :phone
      t.integer :status,:limit => 1

      t.timestamps
    end
  end
end
