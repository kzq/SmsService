module SmsService::Service
###Message####################################################
  class Message
    def initialize msg
        @message=msg
        @sms=[]
    end
  
    def extract
      is_single? ? push_single : push_multi
      @sms
    end
    
    def is_single?
      @message.first.is_a?(String) && @message.size==2 ? true : false
    end
    
    def push_single
      @sms << (SMS.new @message.first,@message.last)
    end
    
    def push_multi
      @message.each do |msg|
        if msg.is_a?(Hash)
          @sms << msg.to_sms    
        elsif msg.is_a?(Array)
          @sms << msg.to_sms
        end
      end
    end
  end
###SMS###################################################################
  class SMS
    attr_accessor :text,:to 
    def initialize text,to
      @text,@to,=text,to
    end
   end   

end ###module => SmsService::Service
###Hash#################################################################
class Hash
   def to_sms
     unless empty?
      msg=self[:message]
      to=self[:to]
      SmsService::Service::SMS.new msg.to_s,to.to_s unless msg.empty? && to.emtp?
     end
   end
end
###Array################################################################
class Array
  def to_sms
    SmsService::Service::SMS.new first.to_s,last.to_s if size==2  
  end
end    