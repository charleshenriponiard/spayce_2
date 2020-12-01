class RegistrationsController < Devise::RegistrationsController
  before_action :send_email_to_admin, only: :destroy

  protected

  def send_email_to_admin
    AdminMailer.remove_account(resource).deliver_later
  end

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
