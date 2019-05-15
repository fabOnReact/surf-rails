module ApplicationHelper
  def mobileApp?
    android? || iphone?
  end
  
  def landingPage?
    params[:page] == "landing"
  end

  def navbar?
    mobileApp? || landingPage?
  end

  def android?
   request.env["HTTP_USER_AGENT"].match(/Android/).present?
  end

  def iphone?
    request.env["HTTP_USER_AGENT"].match(/iPhone/).present?
  end
end
