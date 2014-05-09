module ProductTypeExtension
  %w(cabinet laminate misc_cabinet misc_laminate).each do |product_type|
    klass_name = "#{product_type}_product".classify
    method_name = product_type.pluralize

    define_method method_name do
      where(product_type: klass_name)
    end

  end
end
