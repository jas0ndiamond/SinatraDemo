require 'sinatra'
require 'net/http'
require "base64"

class MultiCam < Sinatra::Base
  
  def initialize(app = nil, params = {})
    
    super(app)
    
    @nodes = [ "doorbell", "kiosk"]
  end
  
  get '/' do
    
    out = "<html><body>"
    
    @nodes.each do |node| 
      out << "<b>#{node}</b><br>"
      url = URI.parse("http://#{node}:4567/cam")
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }

      image_data = Base64.encode64(res.body)
      
      out << "<img src=\"data:image/jpeg;base64,#{image_data}\"/><br><hr>\n"
    end 
    
    return out << "</body></html>"
  end

end

use MultiCam
