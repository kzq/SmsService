config=SmsService.configure(
  :textmarketer=> {
    :username=>"39239",
    :password=>"spayr",
    :orig=>"FFCF"
  },
  :bulksms=> {
    :username=>"kingston_st",
    :password=>"DashKam55",
    :allow_concat_text_sms=>1,
    :concat_text_sms_max_parts=>3,
    :repliable=>0,
    :routing_group=>2
    #:eapi_url=>"http://www.usa.bulksms.com:5567"
  },
  :infobip=> {
    :username=>"DBtech1",
    :password=>"DAsh123!",
    :from=>"DTTT"
  },
  #:service=>:textmarketer
  #:service=>:bulksms   
  :service=>:infobip  
)
=begin
config=SmsService.configure(
    :infobip=> {
    :username=>"DBtech1",
    :password=>"DAsh123!",
    :from=>"FFCFDT"
    },
    :service=>:infobip  
)
=end
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
#c=SmsService::Configuration.instance
#puts c.is_a?(SmsService::Configuration)
#c.service
#puts c.service
#c.service=:textmarketer
#puts "c.service=#{c.service} ,c.data=#{c.data}"
#=end
#c=SmsService::Configuration.option
#c=SmsService::Configuration.service=:textmarketer
#puts c
#config=SmsService.config[SmsService.config[:default_service]]
#puts config
#send =SmsService.send()
#send =SmsService.send({})
#send =SmsService.send("ddf ghh")
#########textmarketer
=begin
#results =SmsService.send("FFCF Job offer 123456","447877743313")
#results=SmsService.send(["KU Job offer 123456","447877743313"],["KU Job offer 1234567","447459486342"])
#results=SmsService.send({:message=>"I am single Hash",:to=>"447877743313"}) 
#results=SmsService.send({:to=>"447877743313",:message=>"I am first hash"},{:message=>"I am second hash",:to=>"447459486342"}) 
results.each do |result|
  puts "=====#{result.message_id}=========="
  puts "response=#{result.response}"
  puts "status=#{result.status}"
  puts "message_id=#{result.message_id}"
  puts "credits_left=#{result.credits_left}"
  puts "credits_used=#{result.credits_used}"
end
=end
#########Bulksms
#results =SmsService.send(["KU Job offer 123","447877743313"])
#results =SmsService.send(["KU Job offer 123456","447877743313"],["KU Job offer 1234567","447459486342"])
#results=SmsService.send({:message=>"I am single Hash",:to=>"447877743313"}) 
#results=SmsService.send({:to=>"447877743313",:message=>"I am \nfirst \"l\" hash"},{:message=>"I am second hash",:to=>"447459486342"}) 
#results.each do |result|
#  puts "=====#{result.batch_id.to_s}=========="
#  puts "response=#{result.response}"
#  puts "status_code=#{result.status_code}"
#  puts "status_description=#{result.status_description}"
#  puts "batch_id=#{result.batch_id}"
#end
#############infobip
#=begin
results =SmsService.send(["KU Job offer 123","447877743313"])
#results =SmsService.send(["KU Job offer 123456","447877743313,447459486342"])
#results =SmsService.send(["KU Job offer 123456","447877743313,447459486342"],["KU Job offer 1234567","447459486342"])
#results=SmsService.send({:message=>"I am single Hash",:to=>"447877743313"}) 
#results=SmsService.send({:to=>"447877743313",:message=>"I am first hash"},{:message=>"I am second hash",:to=>"447459486342"}) 

results.each do |result|
  puts "=============start====================================================================="
  puts "response===#{result.response}"
  puts "============================"
  puts "messages===#{result.messages}"
  puts "============================"
  puts "message===#{result.message}"
  puts "============================"
  puts "total_credits_used==#{result.total_credits_used}"
  puts "============================"
  puts "credits_used==#{result.credits_used}"
  puts "============================"
  puts "bulkid===#{result.bulkid}"
  puts "============================"
  puts "message_id===#{result.message_id}"
  puts "==============end======================================================================="
end
#=end
#send =SmsService.send(["ddf ghh","8899887,8899887"],["ddf ghh","8899887"]) 
#send =SmsService.send({:message=>"adsd",:to=>"79898798"}) 
#send =SmsService.send({:message=>"adsd",:to=>"79898798"},{:message=>"adsd",:to=>"79898798"}) 
#puts send
#[[1,'a'],[2,'b'],[3,'c']].map {|e| puts e.first}
#puts [[1,'a'],[2,'b'],[3,'c']].map &:first
#puts [[1,'a'],[2,'b'],[3,'c']].map &:inspect
#str = c.class.to_s
#puts str[str.rindex(':')+1..-1].gsub(/([a-z\d]+)([A-Z])/,'\1_\2').downcase.to_sym
#args={:message => 'Hello, I hope you like my message!', :recipient => '44799123456'}
#args=[{:message => 'Test Message', :recipient => "44342134131"}, {:message => "Another Msg", :recipient => "4441234354254"}]
#msg = args.shift
#puts msg
#msg = args.shift
#puts msg
#args=['Hello, I hope you like my message!','Me'],['2','22']
#puts args.size
#msg = args.shift
#puts msg.class
#args=[["ddf ghh","8899887,8899887"],["ddfokghh","8899887"]]
#msg = args.shift
#puts msg
#msg = args.shift
#puts msg

