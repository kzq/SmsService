require 'singleton'
module SmsService
  #
  # default parameters for sms service. It will be overridden by the 
  # parameters given in configuration file or given at method call 
  # This class can have only one instance
  #
  class Configuration
    include Singleton	
  	attr_accessor :data
  	
  	OPTIONS=[
  		:service,
  		:username,
  		:password,
      :sender
  	]

  	# on initialize pouplate @data with blank config
  	def initialize
      @data={}
    end	
  	
  	# merge dafault with the user given options specified using Smsservice.configure method
  	def configure(options)
      @data.rmerge!(options)
  	end
  	
  	#
  	# define instance level getter/setter methods
  	# for each configuration/option so that we can do 
  	# Configuration.instance.service
  	# and Configuration.instance.service=
  	#
    OPTIONS.each do |option|
     define_method option do
     	@data[option]
     end
     define_method "#{option}=" do |value|
       @data[option]=value
     end
    end	
    #
  	# define class level getter/setter methods
  	# for each configuration/option so that we can do 
  	# Configuration.username
  	# and Configuration.username=
  	#
   instance_eval(
    	OPTIONS.map do |option|
          o = option.to_s
          <<-EOS
            def #{o}
              instance.data[:#{o}]
            end
            def #{o}=(value)
              instance.data[:#{o}] = value
            end
          EOS
        end.join("\n\n")
    )

  end# end configuraion class

end #end Module
