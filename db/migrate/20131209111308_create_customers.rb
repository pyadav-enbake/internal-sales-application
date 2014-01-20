class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.integer :contractor_id
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.string :phone
      t.integer :status,:limit => 1

      t.timestamps
    end
  end
end
