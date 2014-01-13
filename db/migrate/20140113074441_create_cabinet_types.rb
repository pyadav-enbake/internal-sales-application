class CreateCabinetTypes < ActiveRecord::Migration
  def change
    create_table :cabinet_types do |t|
      t.string :name
      t.integer :status,:limit =>1

      t.timestamps
    end
  end
end
