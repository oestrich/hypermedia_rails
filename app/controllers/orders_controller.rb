class OrdersController < ApplicationController
  before_filter :authenticate_user!

  respond_to :json

  has_scope :date

  def index
    orders = current_user.orders.date_descending
    respond_with apply_scopes(orders), :serializer => OrdersSerializer, :date => params[:date]
  end
end
