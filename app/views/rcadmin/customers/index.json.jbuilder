json.array!(@rcadmin_customers) do |rcadmin_customer|
  json.extract! rcadmin_customer, :id, :first_name, :last_name, :adress, :city, :state, :zip, :email, :phone, :status
  json.url rcadmin_customer_url(rcadmin_customer, format: :json)
end
