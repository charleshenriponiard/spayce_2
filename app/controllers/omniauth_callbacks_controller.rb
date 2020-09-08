class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def stripe_connect
    auth_data = request.env["omniauth.auth"]
    @user = current_user

    if @user.persisted?
      @user.provider = auth_data.provider
      @user.uid = auth_data.uid
      @user.access_code = auth_data.credentials.token
      @user.publishable_key = auth_data.info.stripe_publishable_key
      @user.save

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
