require 'net/http'
require 'net/https'
require 'uri'
require 'json'
require 'nokogiri'
module SmsService::Service
  
  class Base
    def query_url(query)
        fail
    end
    
    def convert_keys_to_s options
      result = {}
      options.each do |key,value|
        result[key.to_s] = value
      end
      result
    end
    
    def http_request uri,headers={}
      Net::HTTP::Post.new(uri,headers)  
    end
    
    def basic_auth?
      false
    end
    
    def headers
      {}
    end
    
    def call_api uri,form_data={}
      uri=URI.parse(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == "https"
      request = http_request uri,headers
      request.basic_auth params[:username], params[:password] unless !basic_auth?
      set_form_data(request,form_data)  unless request.class.to_s=="Net::HTTP::Get"
      response=http.request(request)
      response.body
    end
    
  end

end    