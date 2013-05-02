#!/usr/bin/env ruby

require File.expand_path('../config/environment',  __FILE__)
require 'capybara/server'

Capybara.server do |app, port|
  require 'rack/handler/thin'
  Thin::Logging.silent = true
  Rack::Handler::Thin.run(app, :Port => port)
end

server = Capybara::Server.new(Rails.application, 8888)
server.boot

puts "Server booted"

user = User.create({
  :email => "user-#{SecureRandom.hex(10)}@example.com",
  :password => "password",
  :password_confirmation => "password"
})

user.orders.create(:total_cents => 1000)

class Middleware < Faraday::Middleware
  def call(env)
    env[:request_headers]["Accept"] = "application/hal+json"

    @app.call(env)
  end
end

client = Faraday.new("http://localhost:8888") do |conn|
  conn.use Middleware
  conn.adapter Faraday.default_adapter
end

client.basic_auth(user.authentication_token, "")
root = JSON.parse(client.get("/").body)
orders_link = root["_links"]["http://example.com/rels/orders"]["href"]
puts JSON.pretty_generate(JSON.parse(client.get(orders_link).body))
