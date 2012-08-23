require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Orders" do
  header "Accept", "application/hal+json"
  header "Content-Type", "application/hal+json"

  parameter :auth_token, "Authentication token"

  let(:user) { create(:user) }
  let(:auth_token) { user.authentication_token }

  get "/orders" do
    parameter :date, "Search by date"

    let!(:order_1) do
      create(:order, {
        :date => "2012-08-20",
        :total_cents => 4000,
        :status => "shipped",
        :user => user
      })
    end

    let!(:order_2) { create(:order, :date => "2012-08-21", :user => user) }
    let!(:order_3) { create(:order) }

    let(:raw_post) { params.to_json }

    example "Listing orders" do
      do_request

      response_body.should be_json_eql({
        :_embedded => {
          :orders => [
            {
              :date => "2012-08-21",
              :total_cents => 5000,
              :status => "charged",
              :_links => {
                :self => { :href => "/orders/#{order_2.id}" }
              }
            },
            {
              :date => "2012-08-20",
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

      response_headers["Content-Type"].should == "application/hal+json; charset=utf-8"
    end

    example "Listing orders - searching by date" do
      do_request(:date => "2012-08-20")

      response_body.should be_json_eql({
        :_embedded => {
          :orders => [
            {
              :date => "2012-08-20",
              :total_cents => 4000,
              :status => "shipped",
              :_links => {
                :self => { :href => "/orders/#{order_1.id}" }
              }
            }
          ],
        },
        :_links => {
          :self => { :href => "/orders?date=2012-08-20" },
          :all  => { :href => "/orders" },
          :find => { :href => "/orders{?date}", :templated => true }
        }
      }.to_json)

      status.should == 200

      response_headers["Content-Type"].should == "application/hal+json; charset=utf-8"
    end
  end

  get "/orders/:id" do
    let(:order) { create(:order, :user => user) }
    let(:id) { order.id }

    example "Viewing an order" do
      do_request

      response_body.should be_json_eql({
        :date => order.date,
        :total_cents => 5000,
        :status => "charged",
        :_links => {
          :self => { :href => "/orders/#{id}" }
        },
      }.to_json)

      status.should == 200

      response_headers["Content-Type"].should == "application/hal+json; charset=utf-8"
    end
  end

  post "/orders" do
    parameter :total_cents, "Total cents for this order"

    let(:total_cents) { 3000 }

    let(:raw_post) { { :order => { :total_cents => total_cents }, :auth_token => auth_token }.to_json }

    example "Creating a new order" do
      do_request

      response_body.should be_json_eql({
        :date => Date.today,
        :total_cents => total_cents,
        :status => "pending",
      }.to_json).excluding("_links")

      response_body.should have_json_path("_links/self/href")

      status.should == 201

      response_headers["Content-Type"].should == "application/hal+json; charset=utf-8"
    end
  end

  put "/orders/:id" do
    parameter :status, "Update status of order"

    let(:order) { create(:order, :user => user) }
    let(:id) { order.id }

    let(:status) { "charged" }

    let(:raw_post) { { :order => { :status => status }, :auth_token => auth_token }.to_json }

    example "Updating an order" do
      do_request

      response_body.should == ""

      response_status.should == 204

      order.reload.status.should == "charged"
    end
  end
end
