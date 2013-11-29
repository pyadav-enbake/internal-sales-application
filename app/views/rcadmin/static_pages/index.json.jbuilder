json.array!(@rcadmin_static_pages) do |rcadmin_static_page|
  json.extract! rcadmin_static_page, :name, :content
  json.url rcadmin_static_page_url(rcadmin_static_page, format: :json)
end
