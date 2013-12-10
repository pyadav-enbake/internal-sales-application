class AddQuoteCategoryToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :quote_category, :string
  end
end
