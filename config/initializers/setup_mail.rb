ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
:address => "smtp.gmail.com",
:port => 587,
:domain => "gmail",
:user_name => "sandboxtest1987@gmail.com",
:password => "sandboxtest1987",
:authentication => "plain",
:enable_starttls_auto => true
}
