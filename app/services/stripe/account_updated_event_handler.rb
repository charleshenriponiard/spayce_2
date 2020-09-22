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
      @pending_verification = event.data.object.requirements.pending_verification
      @payouts_enabled = event.data.object.payouts_enabled

      if !@user.onboarded && @details_submitted
        hash = { onboarded: true }
        UpdateUserJob.perform_later(@user, hash)
      end

      if !@user.validated? && @payouts_enabled
        hash = { verification_status: 2 }
        UpdateUserJob.perform_later(@user, hash)
      elsif @user.unvalidated? && @pending_verification.any?
        hash = { verification_status: 1 }
        UpdateUserJob.perform_later(@user, hash)
      end
    end

    private

    # def check_user_status_change
    #   byebug
    #   if !@user.verification_status.validated? && @payouts_enabled
    #     hash = { verification_status: 2 }
    #   elsif @user.verification_status.not_validated? && @pending_verification.empty?
    #     hash = { verification_status: 1 }
    #   end
    # end
  end
end
