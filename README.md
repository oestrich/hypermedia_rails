# Hypermedia API with Rails

This is a Hypermedia API example in Rails.

It uses several cool gems that are good for hypermedia and/or APIs:

* active_model_serializers
* rspec_api_documentation
* raddocs

## Getting going

Here's how to give this a try. First, you'll need Postgres installed and
running. Next, run these commands:

```bash
$ git clone https://github.com/oestrich/hypermedia_rails.git
$ cd hypermedia_rails
$ bundle
$ RAILS_ENV=test bundle exec rake db:create db:migrate
$ RAILS_ENV=development bundle exec rake db:create db:migrate
$ bundle exec rake spec
```

You should see all the tests pass.

## Hypermedia client

A basic example of using hypermedia is included via Faraday. The script will boot up it's own server, create a user and order, and finally show the order. You should be able to change the orders url and the script will continue to work, providing its using hypermedia.

To try it, just

```bash
$ bundle exec ruby hypermedia.rb
```
