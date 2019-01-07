# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # https://stackoverflow.com/questions/7600347/rails-api-design-without-disabling-csrf-protection#15056471
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    respond_to do |format|
      format.html { super }
      build_resource(sign_up_params)
      if resource.save
        sign_up(resource_name, resource)
        format.json { render json: resource, status: :created }
      else
        clean_up_passwords resource
        set_minimum_password_length
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end
end
