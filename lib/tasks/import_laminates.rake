require 'csv'

desc 'Import Categories and its Products from file'
task import_laminates: :environment do

  ActiveRecord::Base.transaction do
    file_path = Rails.root.join("lib/tasks/laminate-top.csv")
    LaminateTask.new(file_path).import
  end
end

desc 'Update Laminate Products Prices'
task update_laminates_price: :environment do

  ActiveRecord::Base.transaction do
    file_path = Rails.root.join("lib/tasks/laminate-top-updated.csv")
    LaminateTask.new(file_path).update
  end
end
