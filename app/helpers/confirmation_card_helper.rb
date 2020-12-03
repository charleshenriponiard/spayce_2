module ConfirmationCardHelper

  def confirmation_card(details, data_client)
    content_tag :div, class: "bill_details" do
      content_tag(:span, details, style: 'min-width: fit-content') + content_tag(:span, "#{data_client}", class: "mx-3 text-right")
    end
  end
end
