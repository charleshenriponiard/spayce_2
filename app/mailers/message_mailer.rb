class MessageMailer < ApplicationMailer
  def contact_me(message, user)
    @body = message.body
    @subject = message.subject
    @email = user.email

    mail to: 'cedricsauvagetpro@gmail.com', from: @email, subject: @subject
  end
end
