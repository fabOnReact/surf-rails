class ApplicationController < ActionController::Base
  # before_action :authenticate_user! #, except: [:landing, :index]
  acts_as_token_authentication_handler_for User #, except: [:landing, :index]
  # protect_from_forgery with: :exception
  def after_sign_in_path_for(resource); posts_path; end
end
