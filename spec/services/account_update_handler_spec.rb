require "rails_helper"
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe Stripe::AccountUpdatedEventHandler do
  before(:each) do
    @stripe_test_helper = StripeMock.create_test_helper
    StripeMock.start

    customer = Stripe::Customer.create({
      email: "johnny#{rand(1..100)}@appleseed.com",
      source: @stripe_test_helper.generate_card_token
    })

    @user = create(:user, uid: customer.id)

    @event_basic = StripeMock.mock_webhook_event(
      'account.updated',
      { id: customer.id,
        details_submitted: false,
        requirements: {
          currently_due: [
          ]
        }
      }
    )
    @event_details_submitted = StripeMock.mock_webhook_event(
      'account.updated',
      { id: customer.id,
        requirements: {
          currently_due: [
          ]
        }
      }
    )
    @event_currently_due = StripeMock.mock_webhook_event(
      'account.updated',
      {
        id: customer.id,
        requirements: {
          currently_due: [
            "individual.verification.additional_document",
            "individual.verification.document"
          ]
        }
      }
    )
    @event_payouts_enabled = StripeMock.mock_webhook_event(
      'account.updated',
      {
        id: customer.id,
        payouts_enabled: true,
        requirements: {
          currently_due: [
          ]
        }
      }
    )
    @account_event_handler = Stripe::AccountUpdatedEventHandler.new
  end

  after(:each) do
    StripeMock.stop
  end

  describe "#handle_account_updated" do
    it "should not change the verification_status of user for a basic event" do
      @account_event_handler.handle_account_updated(@event_basic)
      @user.reload
      expect(@user.no_account?).to be true
    end

    it "should change the verification_status to onboarded" do
      @account_event_handler.handle_account_updated(@event_details_submitted)
      @user.reload
      expect(@user.onboarded?).to be true
    end

    it "should change the verification_status to information_needed" do
      @account_event_handler.handle_account_updated(@event_currently_due)
      @user.reload
      expect(@user.information_needed?).to be true
    end

    it "should change the verification_status to verified" do
      @account_event_handler.handle_account_updated(@event_payouts_enabled)
      @user.reload
      expect(@user.verified?).to be true
    end
  end
end


