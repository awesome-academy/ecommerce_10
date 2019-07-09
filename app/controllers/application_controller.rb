class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  include CartsHelper
  include ApplicationHelper

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      flash[:danger] = exception.message
      redirect_to root_url
    else
      flash[:danger] = t "require_login"
      redirect_to new_user_session_path
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name]
    devise_parameter_sanitizer.permit :account_update, keys: [:name]
  end
end
