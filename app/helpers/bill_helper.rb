module BillHelper
  def bill_details(details)
    content_tag :div, class: "bill_details #{details[:class] if details.has_key?(:class)}" do
      content_tag(:span, details[:text]) + content_tag(:span, "$ #{details[:price]}")
    end
  end
end
