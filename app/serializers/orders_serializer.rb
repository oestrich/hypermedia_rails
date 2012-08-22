class OrdersSerializer < ActiveModel::ArraySerializer
  include Rails.application.routes.url_helpers

  def as_json(*args)
    hash = super(*args)

    hash["_links"] = {
      :self => { :href => orders_path },
      :find => { :href => "#{orders_path}{?date}", :templated => true }
    }

    hash["_embedded"] = { :orders => hash["orders"] }
    hash.delete("orders")

    hash
  end
end
