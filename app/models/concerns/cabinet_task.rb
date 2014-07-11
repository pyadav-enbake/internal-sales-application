require 'csv'

class CabinetTask
  attr_reader :file_path, :file_content

  def initialize file_path
    @file_path = file_path
  end

  def valid?
    first_row = CSV.open(file_path, headers: true).first
    first_row.headers.select(&:present?).count == 7 &&
      !first_row[3].to_s.strip.sub(/^\$/, '').to_f.zero?
  end

  def import
    CSV.open(file_path, headers: true).each do |row|
      attributes  = parsed_attributes_from row
      types       = parsed_types_from attributes
      create_cabinets_from attributes, types
    end
  end


  def update
    CSV.open(file_path, headers: true).each do |row|
      attributes  = parsed_attributes_from row
      types       = parsed_types_from attributes
      update_cabinets_from attributes, types
    end
  end

  def update_cabinets_from attributes, types
    category_name,    title = attributes[:category],          attributes[:title]
    measurement_type, price = attributes[:measurement_type],  attributes[:price]

    return if category_name.empty? or title.empty? or measurement_type.empty?

    unless price.empty?
      category = Rcadmin::Subcategory.where("LOWER(name) = ?", category_name.downcase).
        first_or_create!(name: category_name, status: 0)

      product = category.cabinet_products.where(
        attributes.slice(:title, :measurement_type, :description, :customer_wording, :status)
      ).first_or_create!(types: types, price: price)

      old_price = product.price

      product.update(price: price)
      puts "Cabinet Product Price Updated: #{product.customer_wording} #{old_price} => #{price}"
    end
  end


  def create_cabinets_from attributes, types
    category_name,    title = attributes[:category],          attributes[:title]
    measurement_type, price = attributes[:measurement_type],  attributes[:price]

    return if category_name.empty? or title.empty? or measurement_type.empty?

    unless price.empty?
      category = Rcadmin::Subcategory.where("LOWER(name) = ?", category_name.downcase).
        first_or_create!(name: category_name, status: 0)

      product = category.cabinet_products.where(
        attributes.slice(:title, :measurement_type, :price, :description, :customer_wording, :status)
      ).first_or_create!(types: types)

      puts "Cabinet Product Created: #{product.customer_wording}"
    end
  end


  def parsed_types_from attributes
    types = []
    types << 'wood'   if attributes[:wood]
    types << 'maple'  if attributes[:maple]

    if attributes[:measurement_type].match(/\d{2}%/)
      if attributes[:title].match(/(MAPLE INTERIORS|ALL PLYWOOD CONSTRUCTION)/i)
        types << 'maple-percentage'
      else
        types << 'wood-percentage'
      end
    end
    types
  end

  def parsed_attributes_from row
    {
      title:            row[0].to_s.strip,
      description:      row[0].to_s.strip,
      category:         row[1].to_s.strip,
      measurement_type: row[2].to_s.strip,
      price:            row[3].to_s.strip.sub(/^\$/, ''),
      wood:             row[4].to_s.strip.present?,
      maple:            row[5].to_s.strip.present?,
      customer_wording: row[6].to_s.strip,
      status:           0
    }
  end

end
