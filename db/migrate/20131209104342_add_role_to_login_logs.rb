class AddRoleToLoginLogs < ActiveRecord::Migration
  def change
    add_column :login_logs, :role, :string
  end
end
