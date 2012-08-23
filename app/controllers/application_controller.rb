class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def respond_with(resource, options = {})
    super(resource, options) do |format|
      format.hal do
        render options.merge(:json => resource)
      end
    end
  end
end
