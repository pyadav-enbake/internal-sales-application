json.array!(@rcadmin_email_templates) do |rcadmin_email_template|
  json.extract! rcadmin_email_template, :template_name, :message_body
  json.url rcadmin_email_template_url(rcadmin_email_template, format: :json)
end
