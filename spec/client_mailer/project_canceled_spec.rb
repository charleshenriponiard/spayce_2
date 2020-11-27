require "rails_helper"
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe ClientMailer, :type => :mailer do
  describe "project_canceled" do
    before(:all)  do
      I18n.locale = :fr
      @user = create(:user, :with_project)
      @mail = ClientMailer.project_canceled(@user.projects.last)
    end

    it 'renders the subject in french' do
      expect(@mail.subject).to eq("Annulation de transfert")
    end

    it 'renders the subject in english' do
      I18n.locale = :en
      @mail = ClientMailer.project_canceled(@user.projects.last)
      expect(@mail.subject).to eq("Transfer cancellation")
    end

    it 'renders the receiver email' do
      expect(@mail.to).to eq([@user.projects.last.client_email])
    end

    it 'renders the sender email' do
      expect(@mail.from).to eq(["cedricsauvagetpro@gmail.com"])
    end

    it 'should_be deliver_later' do
      expect {
        ClientMailer.project_canceled(@user.projects.last).deliver_later
      }.to have_enqueued_job.on_queue('mailers')
    end
  end
end
