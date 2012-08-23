require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Root" do
  header "Accept", "application/hal+json"

  get "/" do
    example "Getting the root resource" do
      do_request

      response_body.should be_json_eql({
        :_links => {
          :orders => { :href => "/orders" }
        }
      }.to_json)

      status.should == 200

      response_headers["Content-Type"].should == "application/hal+json; charset=utf-8"
    end
  end
end
