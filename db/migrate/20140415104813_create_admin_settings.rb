class CreateAdminSettings < ActiveRecord::Migration
  def change
    create_table :admin_settings do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
    AdminSetting.create({
      name: "coversheet_percentage",
      value: "59.0"
    });
  end
end
