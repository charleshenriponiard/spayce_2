module ApplicationHelper
  def stripe_url
    "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{ENV["CONNECT_CLIENT_ID"]}&scope=read_write"
  end

  def stripe_connect_button
    link_to stripe_url, class: "btn btn-info m-4" do
      content_tag :span, "Connect with Stripe"
    end
  end
end
