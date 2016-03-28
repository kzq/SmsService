require 'hash_recursive_merge'
require 'sms_service/configuration'
require 'sms_service/service'
require 'sms_service/services/message'
module SmsService
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
  def self.send(*sms)
  	service=SmsService::Service.get Configuration.service
  	service.send(sms)
  end
end