require './smsservice/services/base'
require "./smsservice/results/textmarketer"
module SmsService::Service
  class Textmarketer < Base
  	
  	def initialize parameters
  	  @params=parameters
  	end
  	
  	def self.name
     "Textmarketer"
  	end
  	
  	
  	def self.api_url
  	  "http://www.textmarketer.biz/gateway/"
  	end
  	
  	def sms_url params
  	  query=@params.merge! params
  	  query=@params.map {|k,v| "#{k}=#{v}"}.join('&')
  	  self.class.api_url+"?"+query
  	end
  	
  	def http_request uri,headers={}
      Net::HTTP::Get.new(uri,headers)  
    end
  	
  	def send message
  	  results=[]
  	  messages=(Message.new message).extract
      messages.each do |sms|
        append_query={:number=>sms.to,:message=>URI.escape(sms.text),:option=>"xml"}
        params=@params.merge! append_query
        uri_with_query_string=sms_url append_query
        xml=call_api uri_with_query_string 
        #xml = '<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE response SYSTEM "http://www.textmarketer.biz/dtd/api_response.dtd"><response status="success" id="257470055" ><credits>188</credits><credits_used>1</credits_used></response>'
        response = SmsService::Result::Textmarketer.fetch_response xml
        results << response  
      end
      results
    end
      
    
     
  end 
end
