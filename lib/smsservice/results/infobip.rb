module SmsService::Result
  class Infobip
    
    def initialize xml,complte_xml 
      @xml=xml;@message=message;@complete_xml=complte_xml;
    end
    
    def self.fetch_response xml
     xml=Nokogiri::XML xml;messages=[];
     xml.xpath("//message").each { |node| messages << (new node.to_s,xml)}
     messages 
    end
    
    def response
      @complete_xml
    end
    
    def message
     Nokogiri::XML @xml
    end
    
    def bulkid
      b_l=@complete_xml.at("bulkId") 
      b_l==nil ? "" : b_l.text 
    end 
    
    def message_id
      msg_id=@message.xpath("//messageId")
      msg_id==nil ? "" : msg_id.text
    end
    
    def messages
      m_l=@complete_xml.at("messages")
      m_l==nil ? "" : m_l
    end
    
    def credits_used
      c_u=@message.xpath("//smsCount") 
      c_u==nil ? "" : c_u.text
    end
    
    def total_credits_used
      c_u=@complete_xml.xpath("//smsCount") 
      t_c=c_u.inject(0) {|r,n| r=r+n.text.to_i}
      t_c==nil ? "" : t_c
    end
    
  end 
end