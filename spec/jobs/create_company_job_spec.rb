# require "rails_helper"
# require 'sidekiq/testing'
# Sidekiq::Testing.fake!

# RSpec.describe CreateCompanyJob, type: :job do
#   before(:all) do
#     @user = create(:user, email: "test_job@gmail.com")
#   end

#   describe "#perform_later" do
#     it "enqueued successfully the job" do
#       ActiveJob::Base.queue_adapter = :test
#       expect {
#         CreateCompanyJob.set(queue: "test").perform_later(@user)
#       }.to have_enqueued_job.with(@user).on_queue('test').at(:no_wait)
#     end

#     # it "creates a company linked to an user" do
#     #   ActiveJob::Base.queue_adapter = :test
#     #   @user.update(uid: "acct_1HOlJuETJcLHIQqM")
#     #   CreateCompanyJob.perform_now(@user)
#     #   expect(@user.company).to be_an_instance_of(Company)
#     # end
#   end
# end
