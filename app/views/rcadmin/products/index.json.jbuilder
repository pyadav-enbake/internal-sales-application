json.array!(@rcadmin_products) do |rcadmin_product|
  json.extract! rcadmin_product, :categotry_id, :dimension_id, :name, :price
  json.url rcadmin_product_url(rcadmin_product, format: :json)
end
