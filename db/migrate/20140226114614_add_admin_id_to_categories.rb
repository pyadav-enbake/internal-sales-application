class AddAdminIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :admin_id, :integer
    add_index :categories, :admin_id
  end
end
