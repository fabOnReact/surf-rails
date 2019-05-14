class PagesController < ApplicationController
  acts_as_token_authentication_handler_for User, except: [:show]
  def show
    render template: "pages/#{params[:page]}"
  end
end
