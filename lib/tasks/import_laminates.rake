require 'csv'

desc 'Import Categories and its Products from file'
task import_laminates: :environment do

  ActiveRecord::Base.transaction do

    CSV.open(Rails.root.join("lib/tasks/laminate-top.csv"), headers: true).each do |row|
      # Headers name and spaces matters 
      product_title     = 0 # "PRODUCT TITLE"                             # 0
      subcategory       = 1 # "CATEGORY"                                  # 1
      price_type        = 2 # "PRICE TYPE"                                # 2
      price             = 3 # "   PRICE"                                  # 3
      wood              = 4 # "WOOD UPGRADE"                              # 4
      customer_wording  = 5 # "          CUSTOMER WORDING"                # 6

      if row[product_title] and row[customer_wording]
        value = { 
          title: row[product_title].to_s.try(:strip),
          description: row[product_title].to_s.try(:strip),
          category: row[subcategory].to_s.try(:strip),
          measurement_type: row[price_type].to_s.try(:strip),
          price: row[price].to_s.try(:strip).sub(/^\$/, ''),
          customer_wording: row[customer_wording].to_s.try(:strip),
          wood: row[wood].to_s.strip.present?,
          status: 0
        }


        types = []
        types << 'wood' if value[:wood]

        if value[:measurement_type].match(/\d{2}%/)
          types << 'wood-percentage'
        end

        category_name = value[:category]
        next if category_name.blank? or value[:title].blank? or value[:measurement_type].blank?

        price = value[:price]
        if price.empty?
          value[:title]
        else
          category = Rcadmin::Subcategory.where("LOWER(name) = ?", category_name.downcase).
            first_or_create!(name: category_name, status: 0)

          product = category.laminate_products.where(
            value.slice(:title, :measurement_type, :price, :description, :customer_wording, :status)
          ).first_or_create!
          product.types = types
          product.save!
          
          puts product.customer_wording
        end
      end
    end
  end
end
