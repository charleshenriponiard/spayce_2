class RegistrationStepsController < ApplicationController
  include Wicked::Wizard
  steps :user_info

  def show
    render_wizard
  end

  def update
    current_user.update(user_params)
    stripe = Stripe::Express.new
    uid_hash = stripe.sign_up(current_user)
    if current_user.update(user_params.merge(uid_hash))
      redirect_to stripe.url
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :country)
  end
end
