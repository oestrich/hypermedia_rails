class OrdersController < ApplicationController
  before_filter do
    authenticate_or_request_with_http_basic do |auth_token, _|
      @current_user = User.find_by_authentication_token(auth_token)
      @current_user.present?
    end
  end

  respond_to :hal

  has_scope :date

  def index
    orders = current_user.orders.date_descending
    respond_with apply_scopes(orders),
      :serializer => OrdersSerializer, :date => params[:date]
  end

  def show
    order = current_user.orders.find(params[:id])
    respond_with order
  end

  def create
    order = current_user.orders.create(params[:order])
    respond_with order
  end

  def update
    order = current_user.orders.find(params[:id])
    order.status = params[:order][:status] if params[:order][:status]
    order.save
    respond_with order
  end

  def destroy
    order = current_user.orders.find(params[:id])
    order.destroy
    respond_with order
  end
end
