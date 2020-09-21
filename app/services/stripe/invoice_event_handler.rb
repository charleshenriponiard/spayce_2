module Stripe
  class InvoiceEventHandler
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

    def handle_invoice_payment_failed(event)
    end

    def handle_balance_available(event)
    end

    def handle_account_updated(event)
      p event
    end

    def handle_invoice_payment_succeeded(event)
    end
  end
end
