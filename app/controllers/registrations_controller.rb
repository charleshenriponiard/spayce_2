class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    registration_steps_path
  end

  def after_inactive_sign_up_path_for(resource)
    account_confirmation_path
  end

  def after_update_path_for(resource)
    root_path
  end
end
