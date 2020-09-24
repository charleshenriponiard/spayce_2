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

    it "should be a good body" do
      VCR.use_cassette 'stripe_sign_up' do
        get :sign_up
        body = '<html><body>You are being <a href="https://connect.stripe.com/express/onboarding/j6YIC1oYgKyg">redirected</a>.</body></html>'
        expect(response.body).to eql(body)
      end
    end
  end

  describe 'Get #dashboard_connect' do
    login_user
    it "should return a status 302" do
      @user.update(uid: "acct_1HUEcZLNaxcoqDmg")
      VCR.use_cassette 'stripe_onboarding' do
        get :dashboard_connect
        expect(response).to have_http_status(302)
      end
    end

    it "should be a good body" do
      VCR.use_cassette 'stripe_onboarding' do
        @user.update(uid: "acct_1HUEcZLNaxcoqDmg")
        get :dashboard_connect
        body = '<html><body>You are being <a href="https://connect.stripe.com/express/dQ0zAyY5xp8B">redirected</a>.</body></html>'
        expect(response.body).to eql(body)
      end
    end
  end

  describe 'Create Stripe::Express instance' do
    login_user
    it "return an instance" do
      @controller = StripesController.new
      stripe_express = @controller.instance_eval{ create_stripe_express }
      expect(stripe_express).to be_instance_of(Stripe::Express)
    end
  end
end
