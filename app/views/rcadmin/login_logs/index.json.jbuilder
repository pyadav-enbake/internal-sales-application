json.array!(@rcadmin_login_logs) do |rcadmin_login_log|
  json.extract! rcadmin_login_log, :first_name, :last_name, :email, :login_time, :logout_time, :ip
  json.url rcadmin_login_log_url(rcadmin_login_log, format: :json)
end
