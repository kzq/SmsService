require "spec_helper"

describe SmsService::Service do
  it "lists all supported services" do
      expect(SmsService::Service.all_services).to contain_exactly(:infobip,:bulksms,:textmarketer,)
  end
  
  context "when valid service given" do
    it "returns service object" do
     expect(SmsService::Service.get(:infobip).class).to eq SmsService::Service::Infobip
     expect(SmsService::Service.get(:textmarketer).class).to eq SmsService::Service::Textmarketer    
    end    
  end
  
  context "when invalid service given" do
    it "raises runtime error" do
      expect { SmsService::Service.get(:unknown_service_name) }.to raise_error(RuntimeError)
    end
  end
end