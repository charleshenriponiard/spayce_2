class RegistrationStepsController < ApplicationController
  include Wicked::Wizard
  steps :user_info

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    stripe = Stripe::Express.new
    object = stripe.sign_up(@user)
    if @user.update(user_params.merge(object))
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
