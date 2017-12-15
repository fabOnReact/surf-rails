module ActionDispatch
  class Request
    SERVER_IP = '0.0.0.0'
    MY_STATIC_IP = '98.236.166.116'
    def get_remote_ip
      self.remote_ip
    end

    def ip_finder
      case self.get_remote_ip
          when SERVER_IP then MY_STATIC_IP
          else self.remote_ip
      end
    end  
  end
end