module ActionDispatch
  class Request
    SERVER_IP = ['0.0.0.0', '127.0.0.1']
    MY_STATIC_IP = '82.54.103.29'
    
    def static_ip_finder
      case self.remote_ip
          when *SERVER_IP then MY_STATIC_IP
          else self.remote_ip
      end
    end  

    def self.server_ip
      SERVER_IP
    end

    def self.my_static_ip
      MY_STATIC_IP
    end
  end
end