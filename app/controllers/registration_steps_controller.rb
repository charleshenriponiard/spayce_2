class RegistrationStepsController < ApplicationController
  include Wicked::Wizard
  steps :user_info

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    account = Stripe::Account.create({
      country: @user.country,
      type: 'express',
      requested_capabilities: ['card_payments', 'transfers'],
    })
    @account_links = Stripe::AccountLink.create({
      account: account["id"],
      refresh_url: 'http://localhost:5000',
      return_url: 'http://localhost:5000',
      type: 'account_onboarding',
    })
    object = { uid: account.id }
    if @user.update(user_params.merge(object))
      redirect_to @account_links["url"]
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :country)
  end

end
