class WelcomeMailer < ActionMailer::Base
  default from: "from@example.com"
  def testmail()
	mail :to => 'akankshita009@gmail.com', :from => "email@domain.com", :subject => "Subject line"
  end
end
