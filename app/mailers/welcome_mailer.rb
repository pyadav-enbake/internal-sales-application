class WelcomeMailer < ActionMailer::Base
  default from: "from@example.com"
  def testmail()
    mail :to => 'akankshita009@gmail.com', :from => "email@domain.com", :subject => "Subject line"
  end

  def send_quote_mail(customer_id,quote_id)
    @customer_id = customer_id
    @quote_id = quote_id
    mail :to => 'akankshita009@gmail.com', :from => "email@domain.com", :subject => "Quote Request"
    # mail :to => 'justin@acapellahq.com', :from => "email@domain.com", :subject => "Quote Request"
  end

  def send_quote_mail_customer(customer,quote_id)
    @customer = customer
    @quote_id = quote_id
    mail :to => "#{@customer.email}", :from => "email@domain.com", :subject => "Quote Request"
  end


end
