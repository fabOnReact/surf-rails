class ApplicationController < ActionController::Base
  acts_as_token_authentication_handler_for User #, except: [:landing, :index]
  protect_from_forgery unless: -> { request.format.json? }
  skip_before_action :verify_authenticity_token, if: :json_request?
  # before_action :authenticate_user! #, except: [:landing, :index]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def json_request?
    request.format.json?
  end

  def after_sign_in_path_for(resource) 
    posts_path(latitude: params[:latitude], longitude: params[:longitude]) 
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end
