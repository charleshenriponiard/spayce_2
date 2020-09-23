require 'rails_helper'

RSpec.describe  Stripe, type: :model do
  before(:all) do
    @user = build(:user)
    @stripe = Stripe::Express.new
    @stripe.sign_up(@user)
  end

  describe(:sign_up) do
    it "should have a URL" do
      expect(@stripe.url).to be_a(String)
    end
    it "should have a UID" do
      expect(@stripe.uid).not_to be_nil
    end
  end
end
