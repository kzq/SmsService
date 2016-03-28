# Configure Services
For Rails project you can create sms_services.rb file and place it into initializers directory.


```sh
# MUST set default sms service provider to use, can have one of these three symbols i.e. :textmarketer,
 :bulksms, :infobip. You can change service anytime using the SmsService.configure method 

# configure single service provider
SmsService.configure(
    :infobip=> {
    :username=>"username",
    :password=>"password",
    :from=>"sender"
    },
    :service=>:infobip  
)

#configfure multiple service providers
SmsService.configure(
  :textmarketer=> {
    :username=>"username",
    :password=>"password",
    :orig=>"sender"
  },
  :bulksms=> {
    :username=>"username",
    :password=>"password",
    :allow_concat_text_sms=>1,
    :concat_text_sms_max_parts=>3,
    :repliable=>0,
    :routing_group=>2
    #:eapi_url=>"http://www.usa.bulksms.com:5567", if differet from default eapi 
  },
  :infobip=> {
    :username=>"username",
    :password=>"password",
    :from=>"sender"
  },
  :service=>:bulksms  
)
```
# Send SMS

### Single message
```sh
SmsService.send("Hello world!","44786544321")
SmsService.send({:message=>"Hello world!",:to=>"44786544321"})
```
### Single message to multiple recepients
```sh
SmsService.send("Hello world!","44786544321,44787652309")
```
#Multiple messages
```sh
SmsService.send(["Hello world! to team A","44786544321"],["Hello world! to team A","44787652309"])
SmsService.send({:to=>"44786544321",:message=>"Hello world! to team A"},
				{:message=>"Hello world! to team B",:to=>"44787652309"})
```

### Textmarketer
```sh
#set service to textmarketer if not set already or using different provider  
SmsService.configure(:service=>:textmarketer)
#send sms
results=SmsService.send("Hello world!","44786544321")
results.each do |result|
  result.response
  result.status
  result.message_id
  result.credits_left
  result.credits_used
end
```
### Bulksms
```sh
results =SmsService.send(["Hello world! to team A","44786544321"],["Hello world! to team A","44787652309"])
results.each do |result|
 result.response
 result.status_code
 result.status_description
 result.batch_id
end
```

### Infobip
```sh
results=SmsService.send({:to=>"44786544321",:message=>"I am first hash"},
						{:message=>"I am second hash",:to=>"44787652309,44787549510"}) 
results.each do |result|
  result.response
  result.messages
  result.message
  result.total_credits_used
  result.credits_used
  result.bulkid
  result.message_id
end
```