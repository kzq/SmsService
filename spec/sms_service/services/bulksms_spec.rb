require "spec_helper"
require "sms_service/services/bulksms"

describe SmsService::Service::Bulksms do
  before :all do
    SmsService.configure(:bulksms=> {:username=>"username",:password=>"password",:allow_concat_text_sms=>1,:concat_text_sms_max_parts=>3,:repliable=>0,:routing_group=>2})
    SmsService.configure(:service=>:bulksms)
  end
  let(:bulksms) {SmsService::Service::Bulksms}
  let(:bulksms_service) {SmsService::Service::Bulksms.new SmsService::Configuration.instance.data[:bulksms]}
    
  it "sets eapi_url if given in configurations" do
    SmsService.configure(:bulksms=>{:eapi_url=>"http://www.usa.bulksms.com:5567"})
    expect(bulksms.url_address).to eq "http://www.usa.bulksms.com:5567"
    SmsService::Configuration.instance.data[:bulksms].delete :eapi_url
  end
  
  it "uses valid api url for single message" do
    expect(bulksms.gateway_for_single_sms).to eq "/eapi/submission/send_sms/2/2.0"
  end
  
  it "uses valid api url for multiple messages" do
    expect(bulksms.gateway_for_batch_sms).to eq "/eapi/submission/send_batch/1/1.0"
  end
  
  context "when single text message is given" do
    context "when single recepient is given" do
      it "sends sms" do
        results=bulksms_service.send(["Hello","447987654313"])
        expect(results.first.status_code).to eq "0"
        expect(results.first.status_description).to eq "IN_PROGRESS"
      end
    end
    context "when more than one recepient is given" do
      it "sends sms" do
        results=bulksms_service.send(["Hi Greetings","44787987654313,447835947314"])
        expect(results.first.status_code).to eq "0"
        expect(results.first.status_description).to eq "IN_PROGRESS"
      end
    end  
  end 
  
  context "when multiple text messages are given" do
    it "sends sms" do
      results=bulksms_service.send({:to=>"447877743313",:message=>"I am \nfirst \"l\" hash"},{:message=>"I am second hash",:to=>"447459486342"})    
    end  
  end
end