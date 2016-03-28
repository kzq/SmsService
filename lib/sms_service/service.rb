module SmsService

  module Service
    extend self
    def all_services
     %i(textmarketer bulksms infobip)
    end	
  
    def get(name)
  	  if all_services.include?(name)
  	    require "sms_service/services/#{name.to_s}"
  	    Service.const_get("#{name.capitalize}").new Configuration.instance.data[name]
  	  else
  	    valid_services=all_services.map(&:inspect).join(",")
  	    #raise ConfigurationError, "Please specify a valid service provider for SmsService " +
        # "(#{name.inspect} is not one of: #{valid_services})."
        puts "Please specify a valid service provider for SmsService (#{name.inspect} is not one of the #{valid_services})."
  	  end
  	end	
  
  end

end  
