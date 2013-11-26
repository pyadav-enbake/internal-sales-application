json.array!(@rcadmin_categories) do |rcadmin_category|
  json.extract! rcadmin_category, :name
  json.url rcadmin_category_url(rcadmin_category, format: :json)
end
