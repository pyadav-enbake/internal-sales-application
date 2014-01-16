class AddContractorIdToQuote < ActiveRecord::Migration
  def change
    add_column :quotes, :contractor_id, :integer
  end
end
