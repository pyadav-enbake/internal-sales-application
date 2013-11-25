class CreateLoginLogs < ActiveRecord::Migration
  def change
    create_table :login_logs do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.datetime :login_time
      t.datetime :logout_time
      t.string :ip

      t.timestamps
    end
  end
end
