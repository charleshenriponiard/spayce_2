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

    def handle_account_updated(event)
      p "=> UPDATE ACCOUNT _____________________________________________________________________________________________"
      p event
    end

    def handle_capability_updated(event)
      p "=> CAPABILITY UPDATED _____________________________________________________________________________________________"
      p event
    end

    def handle_person_created(event)
      p "=> PERSON CREATED _____________________________________________________________________________________________"
      p event
    end

    def handle_account_external_account_created(event)
      p "=> EXTERNAL ACCOUNT CREATED _____________________________________________________________________________________________"
      p event
    end

    def handle_invoice_payment_succeeded(event)
    end

    def handle_invoice_payment_failed(event)
    end

    def handle_balance_available(event)
      p "_____________________MICHEK______________________"
    end
  end
end
