require "rails_helper"
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe UserMailer, :type => :mailer do
  describe "user_expired" do
    before(:all)  do
      I18n.locale = :fr
      @user = create(:user, :with_project)
      @mail = UserMailer.user_expired(@user.projects.last)
    end


    it 'renders the subject in french' do
      expect(@mail.subject).to eq("Lien de transfert expiré")
    end

    it 'renders the subject in english' do
      I18n.locale = :en
      @mail = UserMailer.user_expired(@user.projects.last)
      expect(@mail.subject).to eq("Transfer link expired")
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
