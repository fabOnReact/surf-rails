class PagesController < ApplicationController
  acts_as_token_authentication_handler_for User, except: [:show]
  skip_before_action :verify_authenticity_token

  def show
    params[:page] ||= "landing"
    render template: "pages/#{params[:page]}"
  end
end
