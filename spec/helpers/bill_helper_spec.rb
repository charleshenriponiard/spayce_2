describe billHelper do
  describe "#bill_details" do
    it "should return the right content" do
      binding.pry
      answer = bill_details({ text: t('view.project.new.bill_tax'), price: 0.00, class: " bill_detail border-bottom pb-3" })

      helper.bill_details({ text: t('view.project.new.bill_tax'), price: 0.00, class: " bill_detail border-bottom pb-3" }).should eql("My Title")
    end
  end
end
