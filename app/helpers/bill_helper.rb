module BillHelper
  def bill_details(details, data_name)
    content_tag :div, class: "bill_details #{details[:class] if details.has_key?(:class)}" do
      content_tag(:span, details[:text]) + content_tag(:span, "#{number_to_currency(details[:price])}", data: { target: data_name })
    end
  end
end
