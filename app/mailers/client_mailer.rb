class ClientMailer < ApplicationMailer
  default from: 'cedricsauvagetpro@gmail.com'
  layout 'mailer'

  def transfert_project_to_client(project, slug)
    @project = project
    @slug = slug
    mail(to: @project.client_email, subject: 'New tranfer for you')
  end

  def project_canceled(project)
    @project = project
    mail(to: @project.client_email, subject: 'We are sorry but the transfer is canceled')
  end

  def payment_validation(project)
    @project = project
    mail(to: @project.client_email, subject: 'Thanks for the paiment')
  end
end
