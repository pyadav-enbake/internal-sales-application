class AddAbbrToSelectionTypes < ActiveRecord::Migration
  def change
    add_column :selection_types, :abbr, :string
  end
end
