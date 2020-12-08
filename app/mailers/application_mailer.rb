class ApplicationMailer < ActionMailer::Base
  default from: 'cedricsauvagetpro@gmail.com'
  layout 'mailer'

  before_action :add_inline_attachment!

  def add_inline_attachment!
    attachments.inline['logo.jpg'] = File.read("#{Rails.root}/app/assets/images/logo.jpg")
  end
end
