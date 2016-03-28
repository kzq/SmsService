require 'nokogiri'
module SmsService::Result
  class Bulksms
    attr_reader :status_code,:status_description,:batch_id
    
    def initialize response
      @response=response.inspect
      @status_code,@status_description,@batch_id=response.shift,response.shift,response.shift
    end
    
    def self.fetch_response str
     new str.split('|')
    end
    
    def response
     @response    
    end
  end 
end