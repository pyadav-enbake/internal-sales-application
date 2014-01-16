class CreateContractors < ActiveRecord::Migration
  def change
    create_table :contractors do |t|
      t.integer :admin_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :state
      t.string :city
      t.string :address
      t.string :zip
      t.string :phone
      t.integer :status,:limit => 1

      t.timestamps
    end
  end
end
