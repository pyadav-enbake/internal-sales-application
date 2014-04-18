class CreateSelectionTypes < ActiveRecord::Migration
  def change
    create_table :selection_types do |t|
      t.string :name
      t.references :selectable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
