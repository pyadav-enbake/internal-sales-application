class AddFieldDeliverToQuote < ActiveRecord::Migration
  def change
    add_column :quotes, :deliver, :boolean
  end
end
