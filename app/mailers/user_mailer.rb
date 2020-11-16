class UserMailer < ApplicationMailer
  default from: 'cedricsauvagetpro@gmail.com'
  layout 'mailer'

  def kyc_validated(user)
    byebug
    @user = user
    mail(to: @user.email, subject: 'Congratulation your KYC is valide !')
  end
end
