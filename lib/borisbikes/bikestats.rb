require 'httparty'
require 'borisbikes/result'
module BorisBikes
  class Bikestats

    def initialize
      @baseurl = "http://api.bike-stats.co.uk/service/rest/bikestat/"
      @append = "?format=json"
    end

    def get(id)
      url = @baseurl + id.to_s + @append
      res = HTTParty.get(url)
      BorisBikes::Result.new(res.parsed_response)
    end

  end
end
