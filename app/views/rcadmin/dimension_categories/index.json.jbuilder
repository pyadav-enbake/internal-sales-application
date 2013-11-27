json.array!(@rcadmin_dimension_categories) do |rcadmin_dimension_category|
  json.extract! rcadmin_dimension_category, :name
  json.url rcadmin_dimension_category_url(rcadmin_dimension_category, format: :json)
end
