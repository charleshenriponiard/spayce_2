require "rails_helper"
require 'sidekiq/testing'
require "Dhalang"
Sidekiq::Testing.inline!

RSpec.describe UserMailer, :type => :mailer do
  describe "accepted_payment_spec" do
    before(:all) do
      I18n.locale = :fr
      @user = create(:user, :with_project)
      @invoice = Invoice.create(project: @user.projects.last)
      @mail = UserMailer.accepted_payment(@user.projects.last)
      @mail.attachments['invoice.pdf'] = 'https://en.wikipedia.org/wiki/Ruby_on_Railshttps://en.wikipedia.org/wiki/Ruby_on_Rails'
    end

    it 'renders the subject in french' do
      expect(@mail.subject).to eq("Transfert téléchargé")
    end

    it 'renders the subject in english' do
      I18n.locale = :en
      @mail = UserMailer.accepted_payment(@user.projects.last)
      @mail.attachments['invoice.pdf'] = 'https://en.wikipedia.org/wiki/Ruby_on_Railshttps://en.wikipedia.org/wiki/Ruby_on_Rails'

      expect(@mail.subject).to eq("Transfer downloaded")
    end

    it 'renders the receiver email' do
      expect(@mail.to).to eq([@user.email])
    end

    it 'renders the sender email' do
      expect(@mail.from).to eq(["cedricsauvagetpro@gmail.com"])
    end

    it 'should_be deliver_later' do
      expect {
        UserMailer.user_reminder(@user.projects.last).deliver_later
      }.to have_enqueued_job.on_queue('mailers')
    end
  end
end
