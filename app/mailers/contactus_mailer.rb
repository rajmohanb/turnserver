class ContactusMailer < ActionMailer::Base

  default to: "contact@seamconnect.com"
  default from: "hello@seamconnect.com"

  def new_message(message)
    @message = message
    mail(:subject => "Contact Us Notification")
  end
end
