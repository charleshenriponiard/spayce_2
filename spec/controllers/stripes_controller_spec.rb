require 'rails_helper'
require_relative "../support/devise"

RSpec.describe StripesController, type: :controller do
  describe 'Get #sign_up' do
    login_user
    it "should return a status 302" do
      VCR.use_cassette 'stripe_sign_up' do
        get :sign_up
        expect(response).to have_http_status(302)
      end
    end
    it "@user should have a uid" do
      VCR.use_cassette 'stripe_sign_up' do
        get :sign_up
        @user.reload
        expect(@user.uid).not_to be_nil
      end
    end
  end
  # describe 'Get #sign_up' do
  #   login_user
  #   it "should return a status 302" do
  #     get :sign_up
  #     expect(response).to have_http_status(302)
  #   end
  #   it "@user should have a uid" do
  #     get :sign_up
  #     @user.reload
  #     expect(@user.uid).not_to be_nil
  #   end
  # end
  # describe 'Get #dashboard_connect' do
  #   login_user
  #   it "should return a status 302" do
  #     get :dashboard_connect
  #     byebug
  #     expect(response).to have_http_status(302)
  #   end
  # end
end
