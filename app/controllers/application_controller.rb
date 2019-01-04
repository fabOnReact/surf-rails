class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  acts_as_token_authentication_handler_for User

  def after_sign_in_path_for(resource)
    if current_user
      posts_pictures_path
    else
      root_path
    end
  end
end
