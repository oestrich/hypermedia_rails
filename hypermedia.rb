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
end

Order.api.get(Order.api.description.links.orders.href).body.resources.orders.each do |order|
  p Order.new(order)
end
