# frozen_string_literal: true
require 'api/google'

class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    build_resource(sign_up_params)
    set_oauth_user if valid_token?
    resource.save
    respond_to do |format|
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          format.json { render json: resource, status: :created }
          format.html { respond_with resource, location: after_sign_up_path_for(resource) }
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          format.json { render json: resource, status: :created }
          format.html { respond_with resource, location: after_inactive_sign_up_path_for(resource)}
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        format.html { respond_with resource }
        format.json { render json: resource.errors, status: 422 }
      end
    end
  end

  private
  def set_oauth_user
    self.resource = User.find_or_create_by(oauth_params)
    self.resource.password = SecureRandom.base64(50)
  end

  def valid_token?
    Google::Auth.new(token).authorized? if token.present?
  end

  def oauth_params
    params.require(:user).permit(:email)
  end

  def token
    @token ||= params.require(:user).permit(:accessToken).to_h[:accessToken]
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end
end
