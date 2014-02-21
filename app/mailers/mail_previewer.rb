=begin
class MailPreviewer < MailView

  def send_quote_mail
    @quote = Rcadmin::Quote.last
    @customer = @quote.customer
    WelcomeMailer.send_quote_mail_customer(@quote.id)
  end
end
=end
