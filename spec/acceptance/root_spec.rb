require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Root" do
  header "Accept", "application/json"

  get "/" do
    example "Getting the root resource" do
      do_request

      response_body.should be_json_eql({
        :_links => {
          :orders => { :href => "/orders" }
        }
      }.to_json)

      status.should == 200
    end
  end
end
