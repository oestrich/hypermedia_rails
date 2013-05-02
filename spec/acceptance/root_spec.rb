require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Root" do
  header "Accept", "application/hal+json"

  get "/" do
    example "Getting the root resource" do
      do_request

      response_body.should be_json_eql({
        :_links => {
          "http://example.com/rels/orders" => { :href => "/orders" }
        },
        :_embedded => {
          :schema => {
            :order => {
              :description => "An order",
              :type => "object",
              :properties => {
                :id => { :type => "integer" },
                :status => { :type => "string" },
                :total_cents => { :type => "integer" },
                :date => { :type => "date" },
                :created_at => { :type => "datetime" },
                :updated_at => { :type => "datetime" }
              }
            }
          }
        }
      }.to_json)

      status.should == 200

      response_headers["Content-Type"].should == "application/hal+json; charset=utf-8"
    end
  end
end
