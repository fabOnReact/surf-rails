# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # skip_before_action :verify_authenticity_token, only: [:create, :new]
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :verify_authenticity_token

  def create
    respond_to do |format|
      format.json { 
        self.resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
        render :status => 200, :json => resource
      }
      format.html { super }
    end
  end

  def login_failed
    render json: {error: 'Login failed, credentials invalid'}, status: 401
  end
end
