require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Orders" do
  header "Accept", "application/json"

  parameter :auth_token, "Authentication token"

  let(:user) { create(:user) }
  let(:auth_token) { user.authentication_token }

  get "/orders" do
    let!(:order_1) do
      create(:order, {
        :date => Date.yesterday,
        :total_cents => 4000,
        :status => "shipped",
        :user => user
      })
    end

    let!(:order_2) { create(:order, :user => user) }
    let!(:order_3) { create(:order) }

    example "Listing orders" do
      do_request

      response_body.should be_json_eql({
        :_embedded => {
          :orders => [
            {
              :date => Date.today,
              :total_cents => 5000,
              :status => "charged",
              :_links => {
                :self => { :href => "/orders/#{order_2.id}" }
              }
            },
            {
              :date => Date.yesterday,
              :total_cents => 4000,
              :status => "shipped",
              :_links => {
                :self => { :href => "/orders/#{order_1.id}" }
              }
            }
          ],
        },
        :_links => {
          :self => { :href => "/orders" },
          :find => { :href => "/orders{?date}", :templated => true }
        }
      }.to_json)

      status.should == 200
    end
  end
end
