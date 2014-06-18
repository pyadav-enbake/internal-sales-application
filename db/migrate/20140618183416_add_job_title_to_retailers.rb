class AddJobTitleToRetailers < ActiveRecord::Migration
  def change
    add_column :retailers, :job_title, :string
  end
end
