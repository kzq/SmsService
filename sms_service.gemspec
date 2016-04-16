$:.push File.expand_path("../lib", __FILE__)
require "sms_service/version"
Gem::Specification.new do |s|
  s.name     = "sms_service"
  s.version  = SmsService::VERSION
  s.platform = Gem::Platform::RUBY
  s.date     = "2016-03-28"
  s.summary  = "Sending SMS different SMS service providers"
  s.email    = "kami_ravian@yahoo.com"
  s.homepage = "https://github.com/kzq/SmsService"
  s.description = "A ruby gem that enables you to send SMS using multiple vendors like Infobipo, BulkSMS and Textmarketer"
  s.authors  = ["Kamran Qureshi"]
  s.files    = Dir['CHANGELOG.md', 'LICENSE', 'README.md', 'examples/**/*', 'lib/**/*']
  s.require_paths = ["lib"]
  s.add_development_dependency  "rspec"
  s.add_development_dependency  "factory_girl_rails"
  s.license     = 'MIT'
end