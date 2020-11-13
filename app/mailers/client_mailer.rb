class ClientMailer < ApplicationMailer
  default from: 'cedricsauvagetpro@gmail.com'
  layout 'mailer'

  def transfert_project_to_client(project, slug)
    @project = project
    @slug = slug
    mail(to: project.client_email, subject: 'New tranfer for you')
  end
end
