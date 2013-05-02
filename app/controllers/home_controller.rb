class HomeController < ApplicationController
  respond_to :hal

  def index
    root_representation = {
      :_links => {
        "http://example.com/rels/orders" => { :href => orders_path }
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
    }

    respond_with root_representation
  end
end
