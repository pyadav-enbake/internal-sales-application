json.array!(@rcadmin_countertop_designs) do |rcadmin_countertop_design|
  json.extract! rcadmin_countertop_design, :id, :name, :status
  json.url rcadmin_countertop_design_url(rcadmin_countertop_design, format: :json)
end
