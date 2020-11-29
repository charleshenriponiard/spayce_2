class UserMailer < ApplicationMailer
  default from: 'cedricsauvagetpro@gmail.com'
  layout 'mailer'

  def kyc_validated(user)
    @user = user
    mail(to: @user.email, subject: t('mailer.kyc_validated.subject'))
  end

  def freelance_project_canceled(project)
    @project = project
    mail(to: @project.user.email, subject: t('mailer.freelance_project_canceled.subject'))
  end

  def accepted_payment(project)
    @project = project
    if Rails.env.test?
      attachments['invoice.pdf'] = 'This is an invoice'
    else
      attachments['invoice.pdf'] = Dhalang::PDF.get_from_url("#{ENV['INVOICE_URL'] + @project.slug}/invoices/#{@project.invoice.id}")
    end
    mail(to: @project.user.email, subject: t('mailer.accepted_payment.subject'))
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
