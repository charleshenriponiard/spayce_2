require "rails_helper"
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe UpdateProjectJob, type: :job do
  let(:user) { create(:user, :with_project) }
  let(:project) { user.projects.last }

  before(:each) do
    hash = { payment_status: "payment_succeeded",
                status: "paid",
                tax: project.tax,
                spayce_commission: project.commission,
                total: project.total
              }
    UpdateProjectJob.perform_now(project, hash)
  end

  describe "#perfom" do
    it "change payment_status to payment_succeeded" do
      expect(project.payment_succeeded?).to be true
    end

    it "change status to paid" do
      expect(project.paid?).to be true
    end

    it "should add commission spayce" do
      expect(project.spayce_commission).to eq(100.0)
    end

    it "should add tax" do
      expect(project.tax).to be_a(Money)
    end

    it "should add total" do
      expect(project.total).to be_a(Money)
    end

    it "Should create has one invoice" do
      expect(project.invoice.project_id).to eq(project.id)
    end
  end
end
