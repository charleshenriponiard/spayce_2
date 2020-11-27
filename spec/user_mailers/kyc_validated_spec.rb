require "rails_helper"
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe UserMailer, :type => :mailer do
  describe "kyc_validated" do
    before(:all)  do
      I18n.locale = :fr
      @user = create(:user, :with_project)
      @mail = UserMailer.kyc_validated(@user)
    end


    it 'renders the subject in french' do
      expect(@mail.subject).to eq("Inscription à Spayce validée")
    end

    it 'renders the subject in english' do
      I18n.locale = :en
      @mail = UserMailer.kyc_validated(@user)
      expect(@mail.subject).to eq("Spayce registration validated")
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
