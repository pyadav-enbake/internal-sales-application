class CreateCountertopDesigns < ActiveRecord::Migration
  def change
    create_table :countertop_designs do |t|
      t.string :name
      t.integer :status,:limit =>1

      t.timestamps
    end
  end
end
