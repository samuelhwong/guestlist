require 'net/http'
require 'net/https'
require 'json'

module Guestlist
  class RestClient
    def initialize(username, password)
      @api_url = URI('https://guestlistapp.com/api/v0.1')
      @user = username
      @password = password
    end

    def GET(path, params={})
      request = Net::HTTP::Get.new "#{@api_url.request_uri}#{path}"
      authorize request
      return execute(request)
    end

    private

    def authorize(req)
      req.basic_auth(@user, @password)
    end

    def execute(req)
      http = Net::HTTP.new(@api_url.host, 443)
      http.use_ssl = true
      res = http.request(req)
      if res.is_a? Net::HTTPSuccess
        if res.body.nil? or res.body.empty?
          return res.code, nil
        else
          begin
            return res.code, JSON.parse(res.body)
          rescue
            raise "Invalid JSON response: #{res.body}"
          end
        end
      elsif res.is_a? Net::HTTPUnauthorized
        raise "SecurityError, Authorization required"
      elsif res.is_a? Net::HTTPBadRequest
        raise "ArgumentError, #{res.body}"
      else
        raise "HttpCodeException: #{res.code}, #{res.body}"
      end
    end
  end
end
