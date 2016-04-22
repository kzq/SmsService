require 'sms_service/services/base'
require "sms_service/results/bulksms"
module SmsService::Service
  class Bulksms < Base
    
    def initialize params
      @params=params
      self.class.set_api_url self.class.default_api
      unless self.class.url_address == nil
        self.class.set_api_url self.class.url_address
        @params.delete :eapi_url
      end
    end
    
    def self.name
     "BulkSMS"
    end
    
    def self.default_api 
      "http://www.bulksms.co.uk:5567"
    end
    
    def self.set_api_url host 
      uri=URI.parse host
      @api_url="#{uri.scheme}://#{uri.host}#{gateway_for_single_sms}"  
    end
    
    def self.api_url_for_single_sms
      uri=URI.parse(@api_url)
      @api_url="#{uri.scheme}://#{uri.host}#{gateway_for_single_sms}"
    end
    
    def self.api_url_for_batch
      uri=URI.parse(@api_url)
      @api_url="#{uri.scheme}://#{uri.host}#{gateway_for_batch_sms}"
    end
    
    def self.gateway_for_single_sms
      "/eapi/submission/send_sms/2/2.0" 
    end
    
    def self.gateway_for_batch_sms
      "/eapi/submission/send_batch/1/1.0" 
    end
    
    def api_url
      @api_url 
    end
    
    def self.url_address
      SmsService::Configuration.instance.data[:bulksms][:eapi_url] 
    end
    
    def sms_url params
      query=@params.merge! params
      query=@params.map {|k,v| "#{k}=#{v}"}.join('&')
      api_url+"?"+query
    end
    
    def send message
      results=[]
      messages=(Message.new message).extract
      messages.length == 1 ? make_request(messages.first) : make_request(messages,'multi')
    end
    
    def make_request sms,sms_type='single'  
      results=[]
      @api_url=(sms_type=='multi' ? self.class.api_url_for_batch : self.class.api_url_for_single_sms)
      append_query=(sms_type=='multi' ? {:batch_data=>to_batch(sms)} : {:msisdn=>sms.to,:message=>sms.text})
      form_data=convert_keys_to_s @params.merge! append_query
      result=call_api api_url,form_data
      #result='0|IN_PROGRESS|887906255'
      response = SmsService::Result::Bulksms.fetch_response result
      results << response 
      results 
    end
    
    def set_form_data request, form_data
      request.set_form_data(form_data)
      request.body=request.body.gsub("%2C",",") if request.body.to_s.include?("batch_data") 
    end
    
    def to_batch messages
      messages.inject("msisdn,message\n") {|result,sms| result+"\"#{sms.to.to_s}\",\"#{sms.text.to_s}\"\n" }
    end
     
  end 
end
