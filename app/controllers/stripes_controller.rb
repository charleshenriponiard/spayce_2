class StripesController < ApplicationController
  def dashboard_connect
    stripe = Stripe::Express.new
    stripe.dashboard_connect(current_user)
    redirect_to stripe.dashboard_url
  end

  def sign_up
    stripe = Stripe::Express.new
    object = stripe.sign_up(current_user)
    current_user.update(object)
    redirect_to stripe.url
  end
end
