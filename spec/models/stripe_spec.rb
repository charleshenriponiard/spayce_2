require 'rails_helper'

RSpec.describe Stripe, type: :model do
  before(:all) do
    @user = create(:user)
    @stripe = Stripe::Express.new
    VCR.use_cassette 'stripe_sign_up' do
      @stripe.sign_up(@user)
    end
  end

  describe(:sign_up) do
    it "should have a URL" do
      expect(@stripe.url).to be_a(String)
    end
    it "should have a UID" do
      expect(@stripe.uid).not_to be_nil
    end
  end

  describe(:onboarding) do
    it "should have a good URL" do
      @user.update(uid: "acct_1HUEcZLNaxcoqDmg")
      VCR.use_cassette 'stripe_onboarding' do
        @stripe.onboarding(@user)
      end
      expect(@stripe.dashboard_url).to be_a(String)
      expect(@stripe.dashboard_url).to eql("https://connect.stripe.com/express/dQ0zAyY5xp8B")
    end
  end
end
