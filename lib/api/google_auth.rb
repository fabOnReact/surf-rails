class GoogleAuth
  include HTTParty
  base_uri "https://oauth2.googleapis.com"

  def initialize(token)
    @options = { query: { access_token: token } }
  end
  
  def tokeninfo
    @tokeninfo ||= self.class.get("/tokeninfo", @options)
  end

  def authorized? 
    tokeninfo.code == 200
  end
end
