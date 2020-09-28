require 'rails_helper'
require_relative "../support/devise"

RSpec.describe RegistrationStepsController, type: :controller do
  before(:each) do
    @user = create(:user)
  end

  describe "GET show/:id" do
    login_user
    it "should have status 200" do
      get :show, params: { id: "user_info" }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET update/:id" do
    login_user
    it "should update current_user" do
      stripe = Stripe::Express.new
      VCR.use_cassette 'stripe_sign_up_registration_steps' do
        @uid_hash = stripe.sign_up(@user)
        params = { user: { first_name: "jean", last_name: "test", country: 'FR', uid: @uid_hash[:uid]}, id: "user_info" }
        get :update, params: params
      end
      expect(response).to have_http_status(302)
    end
    it "response.body should have the correct instance" do
      stripe = Stripe::Express.new
      VCR.use_cassette 'stripe_sign_up_registration_steps' do
        @uid_hash = stripe.sign_up(@user)
        params = { user: { first_name: "jean", last_name: "test", country: 'FR', uid: @uid_hash[:uid]}, id: "user_info" }
        get :update, params: params
      end
      @user.reload
      expect(response.body).to eql("<html><body>You are being <a href=\"https://connect.stripe.com/express/onboarding/YeDikvDVCKB3\">redirected</a>.</body></html>")
    end
  end
end
