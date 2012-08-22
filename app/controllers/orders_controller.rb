class OrdersController < ApplicationController
  before_filter :authenticate_user!

  respond_to :json

  def index
    respond_with current_user.orders.date_descending, :serializer => OrdersSerializer
  end
end
