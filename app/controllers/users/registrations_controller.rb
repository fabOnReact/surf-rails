# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # https://stackoverflow.com/questions/7600347/rails-api-design-without-disabling-csrf-protection#15056471
  skip_before_action :verify_authenticity_token, only: [:create]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    # copy code from session controller
    puts "----------create action called #{Time.now}----------"
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?

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
          format.html { respond_with resource, location: after_inactive_sign_up_path_for(resource) }
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        format.json { render json: resource.errors, status: :unprocessable_entity }
        format.html { respond_with resource }
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
