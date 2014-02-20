class WelcomeMailer < ActionMailer::Base

  default from: 'rubyonrails4@gmail.com'

  def testmail()
    mail :to => 'akankshita009@gmail.com', :from => "email@domain.com", :subject => "Subject line"
  end

  def send_quote_mail(customer_id, quote_id)
    @customer_id = customer_id
    @quote = Rcadmin::Quote.find(quote_id)

    mail :to => 'rubyonrails3@gmail.com', :from => "", :subject => "Quote Request", layout: false, from: 'rubyonrails4@gmail.com'
    # mail :to => 'justin@acapellahq.com', :from => "email@domain.com", :subject => "Quote Request"
  end

  def send_quote_mail_customer(quote_id)
    @quote = Rcadmin::Quote.find(quote_id)
    @customer = @quote.customer
    mail :to => "#{@customer.email}", :from => "email@domain.com", :subject => "Quote Request"
  end


end
