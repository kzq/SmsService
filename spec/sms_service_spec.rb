require "spec_helper"

describe SmsService do 
  let(:textmarketer) {{:textmarketer=> {:username=>"username",:password=>"password",:orig=>"sender"}}}     
  let(:bulksms) {{:bulksms=> {:username=>"username",:password=>"password",:allow_concat_text_sms=>1}}}
  let(:infobip) {{:infobip=> {:username=>"username",:password=>"password",:from=>"sender"}}}  
  let(:service) {SmsService.configure(:service=>:textmarketer)}
    
  it "sets given configurations" do
    config=SmsService.configure(textmarketer)
    expect(config[:textmarketer]).to eq textmarketer[:textmarketer] 
  end
  
  it "can use only one service at any time" do
    config=SmsService.configure(:service=>:textrmarketer)
    SmsService.configure(:service=>:bulksms)
    expect(config[:service]).to eq :bulksms
  end
  
  it "overrides the previous configuration values" do
    config=SmsService.configure(infobip)
    SmsService.configure(:infobip=>{:username=>"new_username",:password=>"new_password",:from=>"new_sender"})
    expect(config[:infobip][:username]).to eq "new_username"
  end
  
  it "sets default service" do
    config=SmsService.configure(:service=>:infobip)
    expect(config[:service]).to eq :infobip
  end
  
  it "returns all configuaration settings" do
   expect(SmsService.config).to eq SmsService::Configuration.instance.data
  end
  
  it "sends sms" do
    SmsService.configure(bulksms)
    SmsService.configure(:service=>:bulksms)
    result=SmsService.send("Hello world!","44786544321")
    expect(result.first.status_code).to eq "0"  
  end
end
