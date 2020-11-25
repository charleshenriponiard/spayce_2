class UserMailer < ApplicationMailer
  default from: 'cedricsauvagetpro@gmail.com'
  layout 'mailer'

  def kyc_validated
    @user = params[:user]
    mail(to: @user.email, subject: 'Congratulation your KYC is valide!')
  end

  def freelance_project_canceled(project)
    @project = project
    mail(to: @project.user.email, subject: 'Your project was canceled')
  end

  def accepted_payment(project)
    @project = project
    mail(to: @project.user.email, subject: 'Congratulation you have a new payment!')
  end
end


Dhalang::PDF.get_from_html("<html><head></head><body><h1>examplestring</h1></body></html>"
