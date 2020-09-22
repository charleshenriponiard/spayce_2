module Stripe
  class AccountUpdatedEventHandler
    def call(event)
      begin
        method = "handle_" + event.type.tr('.', '_')
        self.send method, event
      rescue JSON::ParserError => e
        # handle the json parsing error here
        raise # re-raise the exception to return a 500 error to stripe
      rescue NoMethodError => e
        #code to run when handling an unknown event
      end
    end

    def handle_account_updated(event)
      @user = User.find_by_uid(event.account)
      @details_submitted = event.data.object.details_submitted
      @currently_due = event.data.object.requirements.currently_due
      @payouts_enabled = event.data.object.payouts_enabled

      if !@user.verified? && @payouts_enabled
        hash = { verification_status: "verified" }
        UpdateUserJob.perform_later(@user, hash)
      elsif !@user.onboarded? && @details_submitted
        hash = { verification_status: "onboarded" }
        UpdateUserJob.perform_later(@user, hash)
      elsif @currently_due.any?
        hash = { verification_status: "information_needed" }
        UpdateUserJob.perform_later(@user, hash)
      end
    end
  end
end
