class ApplicationController < ActionController::Base
  acts_as_token_authentication_handler_for User #, except: [:landing, :index]
  protect_from_forgery with: :exception
  # before_action :authenticate_user! #, except: [:landing, :index]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource); posts_path; end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
