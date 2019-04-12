# frozen_string_literal: true
require 'api/google_auth'

class Users::RegistrationsController < Devise::RegistrationsController
  # https://stackoverflow.com/questions/7600347/rails-api-design-without-disabling-csrf-protection#15056471
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    respond_to do |format|
      # binding.pry
      format.html { super }
      build_resource(sign_up_params)
      set_oauth_user if valid_token?
      if resource.save
        sign_up(resource_name, resource)
        format.json { render json: resource, status: :created }
      else
        clean_up_passwords resource
        set_minimum_password_length
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
    GoogleAuth.new(token).authorized? if token.present?
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
