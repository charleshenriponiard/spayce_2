module StatusHelper
  def badge_for(status)
    case status
    when "sent"
      content_tag(:h5, class:"m-0") do
        content_tag(:span, t('activerecord.attributes.project.status.sent'), class: "badge badge-pill badge-primary")
      end
    when "paid", "paid_expired"
      content_tag(:h5, class:"m-0") do
        content_tag(:span, t('activerecord.attributes.project.status.paid'), class: "badge badge-pill badge-success text-white")
      end
    when "canceled", "unpaid_expired"
      content_tag(:h5, class:"m-0") do
        content_tag(:span, t('activerecord.attributes.project.status.canceled_expired'), class: "badge badge-pill badge-danger")
      end
    end
  end
end
