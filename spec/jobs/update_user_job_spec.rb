require "rails_helper"
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe UpdateUserJob, type: :job do
  before(:all) do
    @user = create(:user)
  end

  describe "#perfom" do
    it "update the user" do
      hash = { verification_status: "onboarded" }
      UpdateUserJob.perform_later(@user, hash)
      @user.reload
      expect(@user.onboarded?).to be true
    end
  end
end
