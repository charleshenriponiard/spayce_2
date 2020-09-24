class StripesController < ApplicationController
  before_action :create_stripe_express, only:  [:sign_up, :dashboard_connect]

  def dashboard_connect
    @stripe.onboarding(current_user)
    redirect_to @stripe.dashboard_url
  end

  def sign_up
    object = @stripe.sign_up(current_user)
    current_user.update(object)
    redirect_to @stripe.url
  end

  private

  def create_stripe_express
    @stripe = Stripe::Express.new
  end
end
