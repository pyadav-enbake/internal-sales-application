class CreateEmailTemplates < ActiveRecord::Migration
  def change
    create_table :email_templates do |t|
      t.string :template_name
      t.text :message_body

      t.timestamps
    end
  end
end
