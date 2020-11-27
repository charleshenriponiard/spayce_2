require "rails_helper"
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe ClientMailer, :type => :mailer do
  describe "client_reminder" do
    before(:all)  do
      I18n.locale = :fr
      @user = create(:user, :with_project)
      @mail = ClientMailer.client_reminder(@user.projects.last)
    end

    it 'renders the subject in french' do
      expect(@mail.subject).to eq("Rappel - Le transfert expire dans 24h")
    end

    it 'renders the subject in english' do
      I18n.locale = :en
      @mail = ClientMailer.client_reminder(@user.projects.last)
      expect(@mail.subject).to eq("Reminder - The transfer expires in 24 hours")
    end

    it 'renders the receiver email' do
      expect(@mail.to).to eq([@user.projects.last.client_email])
    end

    it 'renders the sender email' do
      expect(@mail.from).to eq(["cedricsauvagetpro@gmail.com"])
    end

    it 'should_be deliver_later' do
      expect {
        ClientMailer.client_reminder(@user.projects.last).deliver_later
      }.to have_enqueued_job.on_queue('mailers')
    end
  end
end
