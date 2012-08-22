class OrdersController < ApplicationController
  respond_to :json

  def index
    respond_with Order.date_descending, :serializer => OrdersSerializer
  end
end
