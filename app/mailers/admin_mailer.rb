class AdminMailer < ApplicationMailer
  default from: 'cedricsauvagetpro@gmail.com'
  layout 'mailer'

  def remove_account(user)
    @user = user
    mail(to: 'cedricsauvagetpro@gmail.com', subject: 'Oups un compte en moins !')
  end
end
