class HomeController < ApplicationController
  respond_to :hal

  def index
    root_representation = {
      :_links => {
        :orders => { :href => orders_path }
      }
    }

    respond_with root_representation
  end
end
