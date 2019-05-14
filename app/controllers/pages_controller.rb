class PagesController < ApplicationController
  acts_as_token_authentication_handler_for User, except: [:show]
  def show
    params[:page] ||= "landing"
    render template: "pages/#{params[:page]}"
  end
end
