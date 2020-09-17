class RegistrationStepsController < ApplicationController
  include Wicked::Wizard
  steps :user_info

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    @user.update(user_params)
    render_wizard @user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :country)
  end

end
