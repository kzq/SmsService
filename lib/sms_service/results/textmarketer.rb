module SmsService::Result
  class Textmarketer
    
    def initialize xml
      @xml=xml
      @response=response
    end
    
    def self.fetch_response xml
     new xml
    end
    
    def response
     (Nokogiri::XML @xml).at("response")
    end
    
    def status
      @response.attr("status")  
    end 
    
    def message_id
      @response.attr("id")
    end
    
    def credits_left
      c_l=@response.at("credits")
      c_l==nil ? "" : c_l.text
    end
    
    def credits_used
      c_u=@response.at("credits_used") 
      c_u==nil ? "" : c_u.text
    end
    
  end 
end