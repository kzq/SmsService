require "base64"
require 'sms_service/services/base'
require "sms_service/results/infobip"
module SmsService::Service
  class Infobip < Base
    attr_reader :params
    
    def initialize params
      @params=params
      self.class.set_api_url self.class.default_api
    end
    
    def self.name
     "Infobip"
    end
    
    def basic_auth?
      true
    end
    
    def headers
      { 'content-type'=> 'application/json','accept'=>'application/xml'}
    end
    
    def self.default_api 
      "https://api.infobip.com"
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
      "/sms/1/text/single" 
    end
    
    def self.gateway_for_batch_sms
      "/sms/1/text/multi" 
    end
    
    def api_url
      @api_url 
    end
    
    def sms_url params
      #puts sms
      query=@params.merge! params
      query=@params.map {|k,v| "#{k}=#{v}"}.join('&')
      api_url+"?"+query
    end
    
    def send message
      results=[]
      messages=(Message.new message).extract
      messages.length == 1 ? make_request(messages.first) : make_request(messages,'multi')
    end
    
    def single_textual_messages sms
      @api_url=self.class.api_url_for_single_sms
      query={:to=>sms.to.split(','),:text=>sms.text}
      query.merge!(:from=>@params[:from]) unless @params[:from]==nil
      convert_keys_to_s(query).to_json
    end
    
    def multi_textual_messages sms
      @api_url=self.class.api_url_for_batch
      convert_keys_to_s({:messages=>to_batch(sms)}).to_json
    end
    
    def make_request sms,sms_type='single'  
      results=[]
      form_data=sms_type=='single' ? single_textual_messages(sms) : multi_textual_messages(sms)
      params=@params
      result=call_api api_url,form_data
      response = SmsService::Result::Infobip.fetch_response result
      response.each {|res| results << res}
      results 
    end
    
    def set_form_data request, form_data
      request.body=form_data
    end
    
    def send_single_sms sms  
      results=[]
      @api_url=self.class.api_url_for_single_sms
      append_query={:to=>sms.to,:text=>sms.text}
      params=@params
      form_data=convert_keys_to_s params.merge! append_query
      result=call_api api_url,form_data.to_json
      response = SmsService::Result::Infobip.fetch_response result
      response.each {|res| results << res}
      results 
    end
    
    def send_batch messages
     results=[]
     @api_url=api_url_for_batch
     batch_data="msisdn,message\n#{to_batch messages}"
     append_query={:batch_data=>batch_data}
     params=convert_keys_to_s @params.merge! append_query
     result=call_api_with_post params
     response = SmsService::Result::Bulksms.fetch_response result
     results << response 
     results
    end 
     
    def to_batch messages 
      from,message_s=@params[:from],[]
      (from==nil || from == '') ? from={} : from={:from=>from} 
      messages.inject({}) {|result,sms| message_s << {:to=>sms.to.split(','),:text=>sms.text.to_s}.merge(from)}
      message_s
    end
     
  end 
end
