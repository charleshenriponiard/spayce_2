module BillHelper
  def bill_details(text, amount)
    content_tag :div, class: "d-flex justify-content-between align-items-center my-2" do
      content_tag(:span, text)
      content_tag(:span, "$ #{amount}")
    end
  end
end
