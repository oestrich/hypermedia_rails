#!/usr/bin/env ruby

require 'frenetic'
MyAPI = Frenetic.new({
  'url'          => 'http://hypermedia.dev',
  'username'     => 'qxpRbQpqAw3YugKUpErW',
  'password'     => 'qxpRbQpqAw3YugKUpErW',
  'headers' => {
    'accept' => 'application/hal+json'
  }
})

class Order < Frenetic::Resource
  api_client { MyAPI }

  def self.orders
    api.get(api.description.links.orders.href).body.resources.orders.map do |order|
      new(order)
    end
  end
end

p Order.orders
