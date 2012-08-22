class OrderSerializer < ActiveModel::Serializer
  attributes :date, :status, :total_cents, :_links

  def _links
    {
      :self => { :href => order_path(order.id) }
    }
  end
end
