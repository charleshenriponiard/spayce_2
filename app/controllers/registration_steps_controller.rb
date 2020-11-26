class RegistrationStepsController < ApplicationController
  include Wicked::Wizard
  steps :user_info

  def show
    render_wizard
  end

  def update
    if current_user.update(user_params)
      stripe = Stripe::Express.new
      uid_hash = stripe.sign_up(current_user)
      current_user.update(uid_hash)
      redirect_to stripe.url
    else
      render_wizard
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :country, :entity_name, :siret, :address_line1, :address_line2, :city, :state)
  end
end
