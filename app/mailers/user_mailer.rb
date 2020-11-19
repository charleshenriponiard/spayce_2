class UserMailer < ApplicationMailer
  default from: 'cedricsauvagetpro@gmail.com'
  layout 'mailer'
  @user = params[:user]

  def kyc_validated
    mail(to: @user.email, subject: 'Congratulation your KYC is valide !')
  end
end
