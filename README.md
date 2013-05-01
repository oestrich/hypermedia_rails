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

A basic example of a hypermedia client is included via Frenetic. Make sure to set up a user with the correct auth token.

To try it, just

```bash
$ bundle exec ruby hypermedia.rb
```
