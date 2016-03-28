module SmsService
  ## TO DO
  ## check sms args given and valis
  ## create exception class
  ##

  #
  # merge options into @data and if block given mege those options as well 
  #
  def self.configure(options = nil)
   service=Configuration.instance
   service.configure(options) unless options.nil?
   yield service unless !block_given?
   service.data
  end	
  #
  # Read configuraion data
  #
  def self.config
  	Configuration.instance.data
  end	
  #
  # Send SMS
  #
  def self.send(*args)
  	service=SmsService::Service.new.get Configuration.service
  	#service.blank? ? [] : service.send(args)
  	#puts service.all_services
  	service.send(args)
  end
end #end Module
######################### END MODULE ######################################## 
config=SmsService.configure(
  :textmarketer=> {
    :username=>"username",
    :password=>"password",
    :sender=>""
  },
  :bulksms=> {
    :username=>"username",
    :password=>"password",
    :sender=>""
  },
  :infobip=> {
    :username=>"username",
    :password=>"password",
    :sender=>""
  },
  :service=>:textmarketer     
)

#puts config
#puts "====1======"
#config=SmsService.configure(:textmarketer=>{:username=>"in the kamran"})
#puts config
#puts "=====2====="
#config=SmsService.configure do |config|
#         config.service="my service"
#        end	
#puts config
#puts "=====3====="
#config=SmsService.config
#config=SmsService.config[:default_service]
#config=SmsService.config.default_service
#=begin
c=SmsService::Configuration.instance
#puts c.is_a?(SmsService::Configuration)
#c.service
#puts c.service
c.service=:textmarketer
#puts "c.service=#{c.service} ,c.data=#{c.data}"
#=end
#c=SmsService::Configuration.option
#c=SmsService::Configuration.service=:textmarketer
#puts c
#config=SmsService.config[SmsService.config[:default_service]]

#puts config
send =SmsService.send("ddf ghh","8899887,8899887")
#send =SmsService.send(["ddf ghh","8899887,8899887"],["ddf ghh","8899887"]) 
#send =SmsService.send({:message=>"adsd",:to=>"79898798"},{:message=>"adsd",:to=>"79898798"}) 
#puts send
#[[1,'a'],[2,'b'],[3,'c']].map {|e| puts e.first}
#puts [[1,'a'],[2,'b'],[3,'c']].map &:first
#puts [[1,'a'],[2,'b'],[3,'c']].map &:inspect
str = c.class.to_s
puts str[str.rindex(':')+1..-1].gsub(/([a-z\d]+)([A-Z])/,'\1_\2').downcase.to_sym


