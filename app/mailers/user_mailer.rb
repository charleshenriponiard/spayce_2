class UserMailer < ApplicationMailer
  default from: 'cedricsauvagetpro@gmail.com'
  layout 'mailer'

  def kyc_validated
    @user = params[:user]
    mail(to: @user.email, subject: 'Congratulation your KYC is valide !')
  end

  def freelance_project_canceled(project)
    @project = project
    mail(to: @project.user.email, subject: 'Your project was canceled')
  end
end
