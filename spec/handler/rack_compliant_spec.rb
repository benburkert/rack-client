require File.dirname(__FILE__) + '/../spec_helper'

share_examples_for "Rack Compliant Adapter" do
  context 'GET request' do
    it 'has the proper response for a basic request' do
      response = client.get("/ping")
      response.status.should == 200
      response.body.to_s.should == 'pong'
      response["Content-Type"].should == 'text/html'
      response["Content-Length"].to_i.should == 4
    end

    it 'can handle a temporary redirect response' do
      response = client.get("/redirect")
      response.status.should == 302
      response["Location"].should == "/after-redirect"
    end
  end

  context 'HEAD request' do
    it 'can handle ETag headers' do
      response = client.head("/shelf")
      response.status.should == 200
      response["ETag"].should == "828ef3fdfa96f00ad9f27c383fc9ac7f"
    end
  end
end