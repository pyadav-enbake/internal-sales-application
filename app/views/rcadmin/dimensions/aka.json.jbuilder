json.array!(@rcadmin_dimension_categories) do |rcadmin_dimension|
  json.extract! rcadmin_dimension, :dimension_categotry_id, :lower_limit, :upper_limit
  json.url rcadmin_dimension_url(rcadmin_dimension, format: :json)
end
