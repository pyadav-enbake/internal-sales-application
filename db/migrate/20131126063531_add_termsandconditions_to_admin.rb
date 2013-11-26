class AddTermsandconditionsToAdmin < ActiveRecord::Migration
  def change
	add_column :admins, :terms_and_conditions, :boolean, :default => false
  end
end
