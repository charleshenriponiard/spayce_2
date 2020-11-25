module Stripe
  class PaymentIntentEventHandler
    def call(event)
      begin
        method = "handle_" + event.type.tr('.', '_')
        self.send method, event
      rescue JSON::ParserError => e
        p e
        # handle the json parsing error here
        raise # re-raise the exception to return a 500 error to stripe
      rescue NoMethodError => e
        p e
        #code to run when handling an unknown event
      end
    end

    def handle_payment_intent_succeeded(event)
      @project = Project.find_by_payment_intent_id(event.data.object.id)
      hash = { payment_status: "payment_succeeded",
                status: "paid",
                tax: @project.tax,
                spayce_commission: @project.commission,
                total: @project.total
              }
      UpdateProjectJob.perform_later(@project, hash)
      ZipDocumentsJob.perform_later(@project)
    end

    def handle_payment_intent_payment_failed(event)
      @project = Project.find_by_payment_intent_id(event.data.object.id)
      hash = { payment_status: "payment_failed" }
      UpdateProjectJob.perform_later(@project, hash)
    end
  end
end
