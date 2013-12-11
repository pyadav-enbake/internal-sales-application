json.array!(@rcadmin_subcategories) do |rcadmin_subcategory|
  json.extract! rcadmin_subcategory, :id, :category_id, :name, :status
  json.url rcadmin_subcategory_url(rcadmin_subcategory, format: :json)
end
