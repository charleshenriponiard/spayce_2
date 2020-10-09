class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  include Pundit

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas authorisé à faire cette action."
    redirect_to(root_path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^pages$)|(^registration_steps$)|(^stripes$)/
  end

  def set_locale
    locale = extract_locale_from_accept_language_header
    if params[:locale]
      I18n.locale = params[:locale]
    elsif locale_valid?(locale)
      I18n.locale = locale
    else
      I18n.locale = I18n.default_locale
    end
  end

  def locale_valid?(locale)
    I18n.available_locales.map(&:to_s).include?(locale)
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  def extract_locale_from_accept_language_header
    accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
    return unless accept_language
    accept_language.scan(/^[a-z]{2}/).first
  end
end
