class AddMiscsToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :miscs, :hstore
  end
end
