class CreateRetailers < ActiveRecord::Migration
  def change
    create_table :retailers do |t|
      t.references :quote, index: true
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.string :phone
      t.string :title

      t.timestamps
    end
  end
end
