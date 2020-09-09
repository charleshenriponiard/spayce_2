class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def stripe_connect
    auth_data = request.env["omniauth.auth"]
    @user = current_user
    byebug
    if @user.persisted?
      @user.provider = auth_data.provider
      @user.uid = auth_data.uid
      @user.access_code = auth_data.credentials.token
      @user.publishable_key = auth_data.info.stripe_publishable_key
      @user.save

      # TODO
      # Ajouter une job pour la création de l'entreprise
      # require 'stripe'
      # Stripe.api_key = ENV["STRIPE_PRIVATE_KEY"]
      # @user = Stripe::Account.retrieve('stripe_accout_id ') ex => acct_1HPS7gJt6BoiLZkS
      # créer l'entreprise

      flash[:notice] = "Stripe Account Created and Connected"
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.stripe_connect_data"] = request.env["omniauth.auth"]
    end
  end

  def failure
    flash[:alert] = "Something went wrong with Stripe connection"
    redirect_to root_path
  end
end
