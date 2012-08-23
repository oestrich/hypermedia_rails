# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone

Mime::Type.register "application/hal+json", :hal

ActionDispatch::ParamsParser::DEFAULT_PARSERS[Mime::Type.lookup('application/hal+json')] = 
  lambda do |body|
    JSON.parse(body)
  end
