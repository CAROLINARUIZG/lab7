class ApplicationController < ActionController::Base

  include Pundit::Authorization

  allow_browser versions: :modern
  stale_when_importmap_changes

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, unless: -> { devise_controller? || action_name == 'index' }
  after_action :verify_policy_scoped, if: -> { action_name == 'index' && !devise_controller? }

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  private

  def user_not_authorized
    flash[:alert] = "Dont have access to perform this action"
    redirect_to(request.referrer || root_path)
  end
end