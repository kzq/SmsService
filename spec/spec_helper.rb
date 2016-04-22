require 'bundler/setup'
Bundler.setup
begin
require 'nokogiri'
rescue LoadError => e
  $stderr.puts "The nokogiri gem is not available. Please add it to your Gemfile and run bundle install"
  raise e
end  
require 'sms_service'
RSpec.configure do |config|
  # some (optional) config here
end