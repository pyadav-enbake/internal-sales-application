class CreateFaqCategories < ActiveRecord::Migration
  def change
    create_table :faq_categories do |t|
      t.string :name
      t.text :description
      t.integer :display_order
      t.integer :status ,:limit=>1

      t.timestamps
    end
  end
end
