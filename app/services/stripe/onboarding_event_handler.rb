module Stripe
  class OnboardingEventHandler
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
      user = User.find_by_uid(event.account)
      details_submitted = event.data.object.details_submitted
      if !user.onboarded && details_submitted
        hash = { onboarded: true }
        UpdateUserJob.perform_later(user, hash)
      end
    end
  end
end
