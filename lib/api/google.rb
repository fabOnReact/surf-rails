require "open-uri"
module Google 
  class Auth
    BASE_URI = "https://oauth2.googleapis.com"

    def initialize(token)
      @token = token
    end

    def get_token
      JSON.parse(URI.parse("#{BASE_URI}/tokeninfo?id_token=#{@token}").read)
    end

    def authorized? 
      get_token["email"].present?
    end
  end

  class Maps
    include HTTParty
    base_uri "https://maps.googleapis.com/maps/api"

    def initialize(gps)
      @options = { query: { key: ENV['GOOGLE_MAPS_API_KEY'], location: gps, timestamp: Time.now.to_i }}
    end

    def getTimezone
      self.class.get("/timezone/json", @options)
    end
  end
end
