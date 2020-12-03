class ClientMailer < ApplicationMailer
  default from: 'cedricsauvagetpro@gmail.com'
  layout 'mailer'

  def transfer_project_to_client(project)
    @project = project
    mail(to: @project.client_email, subject: t('mailer.sent_project.subject'))
  end

  def project_canceled(project)
    @project = project
    mail(to: @project.client_email, subject: t('mailer.project_canceled.subject'))
  end

  def payment_validation(project)
    @project = project
    mail(to: @project.client_email, subject: t('mailer.payment_validation.subject'))
  end

  def client_reminder(project)
    @project = project
    mail(to: @project.client_email, subject: t('mailer.client_reminder.subject'))
  end

  def client_expired(project)
    @project = project
    mail(to: @project.client_email, subject: t('mailer.client_expired.subject'))
  end
end
