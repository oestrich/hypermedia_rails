class OrderSerializer < ActiveModel::Serializer
  root false

  attributes :date, :status, :total_cents, :_links

  def _links
    {
      :self => { :href => order_path(order.id) }
    }
  end

  private

  def order
    @object
  end
end
