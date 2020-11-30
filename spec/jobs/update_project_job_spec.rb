require "rails_helper"
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe UpdateProjectJob, type: :job do
  let(:user) { create(:user, :with_project) }
  let(:project) { user.projects.last }
  let(:hash) { {  payment_status: "payment_succeeded",
              status: "paid",
              tax: project.tax,
              spayce_commission: project.commission,
              total: project.total
            } }

  describe "#perfom" do
    it "change payment_status to payment_succeeded" do
      UpdateProjectJob.perform_now(project, hash)
      expect(project.payment_succeeded?).to be true
    end

    it "change status to paid" do
      UpdateProjectJob.perform_now(project, hash)
      expect(project.paid?).to be true
    end

    it "should add commission spayce" do
      UpdateProjectJob.perform_now(project, hash)
      expect(project.spayce_commission).to eq(100.0)
    end

    it "should add tax" do
      UpdateProjectJob.perform_now(project, hash)
      expect(project.tax).to be_a(Money)
    end

    it "should add total" do
      UpdateProjectJob.perform_now(project, hash)
      expect(project.total).to be_a(Money)
    end

    it "Should create has one invoice" do
      UpdateProjectJob.perform_now(project, hash)
      expect(project.invoice.project_id).to eq(project.id)
    end
  end
end
