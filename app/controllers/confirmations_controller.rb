class ConfirmationsController < Devise::ConfirmationsController
  protected

  def before_confirmation_path_for(resource_name, resource)
    account_confirmation_path
  end

  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource) # In case you want to sign in the user
    registration_steps_path
  end
end
