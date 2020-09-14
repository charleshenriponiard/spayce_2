class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    stripe_connect_path
  end
end
