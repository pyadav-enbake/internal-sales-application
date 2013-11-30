class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.integer :faq_category_id
      t.text :question
      t.text :answer
      t.integer :display_order
      t.integer :status,:limit=>1

      t.timestamps
    end
  end
end
