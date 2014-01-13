json.array!(@rcadmin_cabinet_types) do |rcadmin_cabinet_type|
  json.extract! rcadmin_cabinet_type, :id, :name, :status
  json.url rcadmin_cabinet_type_url(rcadmin_cabinet_type, format: :json)
end
