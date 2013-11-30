json.array!(@rcadmin_faqs) do |rcadmin_faq|
  json.extract! rcadmin_faq, :faqs_category_id, :question, :answer, :display_order, :status
  json.url rcadmin_faq_url(rcadmin_faq, format: :json)
end
