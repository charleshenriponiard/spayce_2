module StatusHelper
  def badge_for(status)
    case status
    when "sent"
      content_tag(:h5, class:"m-0") do
        content_tag(:span, "Sent", class: "badge badge-pill badge-primary")
      end
    when "paid"
      content_tag(:h5, class:"m-0") do
        content_tag(:span, "Paid", class: "badge badge-pill badge-success text-white")
      end
    when "canceled", "expired"
      content_tag(:h5, class:"m-0") do
        content_tag(:span, "Canceled / Expired", class: "badge badge-pill badge-danger")
      end
    end
  end
end
