class AddStatusToQuote < ActiveRecord::Migration
  def change
    add_column :quotes, :status, :integer,:limit => 1,:default =>1
    add_column :quotes, :delivery_date, :date
    add_column :quotes, :sales_closing_potential, :string
  end
end
