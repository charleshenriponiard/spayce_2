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
    attachments['attachment.pdf'] = Dhalang::PDF.get_from_url("#{ENV['INVOICE_URL'] + @project.slug}/invoices/#{@project.invoice.id}")
    mail(to: @project.user.email, subject: 'Congratulation you have a new payment!')
  end

  def user_reminder(project)
    @project = project
    mail(to: @project.user.email, subject: t('mailer.user_reminder.subject'))
  end

  def user_expired(project)
    @project = project
    mail(to: @project.user.email, subject: t('mailer.user_expired.subject'))
  end
end
