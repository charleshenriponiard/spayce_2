require 'rails_helper'

RSpec.describe BillHelper, type: :helper do
  describe "#bill_details" do
    it "should return the right content" do
      answer = bill_details({ text: t('view.project.new.bill_tax'), price: 0.00, class: "bill_detail border-bottom pb-3" }, "bill.details")
      expect(answer).to eql("<div class=\"bill_details bill_detail border-bottom pb-3\"><span>Tax</span><span data-target=\"bill.details\">$0.00</span></div>")
    end
  end
end
