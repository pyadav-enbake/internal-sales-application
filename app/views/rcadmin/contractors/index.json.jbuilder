json.array!(@rcadmin_contractors) do |rcadmin_contractor|
  json.extract! rcadmin_contractor, :id, :admin_id, :first_name, :last_name, :email, :state, :city, :address, :zip, :phone, :status
  json.url rcadmin_contractor_url(rcadmin_contractor, format: :json)
end
