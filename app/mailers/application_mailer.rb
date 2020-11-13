class ApplicationMailer < ActionMailer::Base
  default from: 'cedricsauvagetpro@gmail.com'
  layout 'mailer'

  before_action :add_inline_attachment!

  def add_inline_attachment!
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
  end
end
