module Google 
  class Auth
    include HTTParty
    base_uri "https://oauth2.googleapis.com"

    def initialize(token)
      @options = { query: { access_token: token } }
    end
    
    def tokeninfo
      @tokeninfo ||= self.class.get("/tokeninfo", @options)
:q
    end

    def authorized? 
      tokeninfo.code == 200
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

#  def google_map
#    gpsString = gps.join(',')
#    "https://maps.googleapis.com/maps/api/staticmap?center=#{gpsString}&zoom=11&markers=#{gpsString}&key=#{ENV['GOOGLE_MAPS_API_KEY']}&size=300x300&maptype=satellite"
#  end
