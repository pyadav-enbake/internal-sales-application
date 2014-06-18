file_path = Rails.root.join("test/fixtures/romar_example.xlsx")
sheets = Roo::Excelx.new(file_path.to_s)

SheetRow = Struct.new(:item, :measurement_type, :price)


sub_category = Rcadmin::Subcategory.find_by(name: 'Base')
sheets.each do |sheet|
  r = SheetRow.new(*sheet)
  if r.price.kind_of?(Float)
    attributes = {title: r.item, measurement_type: r.measurement_type,
                  price: r.price, subcategory_id: sub_category.id, description: r.item, status: 0}
    Rcadmin::Product.find_or_create_by!(attributes)
  end
end
