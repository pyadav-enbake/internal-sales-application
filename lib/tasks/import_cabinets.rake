require 'csv'

desc 'Import Categories and its Products from file'
task import_cabinets: :environment do

  ActiveRecord::Base.transaction do
    file_path = Rails.root.join("lib/tasks/romar-products.csv")
    CabinetTask.new(file_path).import
  end
end

desc 'Update Cabinet Products Prices'
task update_cabinet_price: :environment do

  ActiveRecord::Base.transaction do
    file_path = Rails.root.join("lib/tasks/romar-products-updated.csv")
    CabinetTask.new(file_path).update
  end
end
