json.array!(@rcadmin_faq_categories) do |rcadmin_faq_category|
  json.extract! rcadmin_faq_category, :name, :description, :display_order, :status
  json.url rcadmin_faq_category_url(rcadmin_faq_category, format: :json)
end
