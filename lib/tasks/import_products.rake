require 'csv'

desc 'Import Categories and its Products from file'
task import_categories: :environment do

  ActiveRecord::Base.transaction do
    CSV.open(Rails.root.join("lib/tasks/romar-products.csv"), headers: true).each do |row|
      if row.first and row[6]
        value = { 
          title: row[0].to_s.try(:strip),
          description: row[0].to_s.try(:strip),
          category: row[1].to_s.try(:strip),
          measurement_type: row[2].to_s.try(:strip),
          price: row[3].to_s.try(:strip).sub(/^\$/, ''),
          customer_wording: row[6].to_s.try(:strip),
          status: 0
        }


        break if value[:measurement_type].match(/\d{2}%/)
        category_name = value[:category]
        next if category_name.blank? or value[:title].blank? or value[:measurement_type].blank?

        price = value[:price]
        if price.empty?
          value[:title]
        else
          category = Rcadmin::Subcategory.where("LOWER(name) = ?", category_name.downcase).
            first_or_create!(name: category_name, status: 0)

          product = category.products.where(
            value.slice(:title, :measurement_type, :price, :description, :customer_wording, :status)
          ).first_or_create!
          
          puts product.customer_wording
        end
      end
    end
  end
end
