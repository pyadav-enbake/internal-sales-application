module ApplicationHelper


  def contractor_list
    contractors = current_user.contractors.order(:created_at).map { |c| [c.company_name, c.id] }
    contractors.insert(1, ["New Contractor", 'new-contractor'])
    contractors.insert(2, ['--------------', nil])
  end

  def customer_list contractor
    p contractor
    customers = contractor.customers.map { |c| [c.fullname, c.id] }
    unless contractor.fullname.eql?("Romar Retail")
      customers.insert(1, ["New Customer", 'new-customer'])
      customers.insert(2, ['--------------', nil])
    end
    customers
  end

  def format_date time
    '%02d-%02d-%d' % [time.day, time.month, time.year]
  end

  def format_phone number
    "#{number[0..2]}-#{number[3..5]}-#{number[6..-1]}"
  end

  def calculate_options_price quote_category, quote_product
    (quote_product.total_price * quote_category.percentage * quote_category.factor / 100).round(2)
  end

 def current_user
     @current_user ||= session[:admin_id] && @current_user = Rcadmin::Admin.find(session[:admin_id]) # Use find_by_id to get nil instead of an error if user doesn't exist
  end
  

 def with_markup total, markup
   markup_amount = total / 100 * markup
   total + markup_amount
 end

 def sections
   [
     {id: 1, name: 'Selection 1'}, {id: 2, name: 'Selection 2'},
     {id: 3, name: 'Selection 3'}, {id: 4, name: 'Selection 4'}
   ].map { |s| OpenStruct.new(s) }
 end


end
