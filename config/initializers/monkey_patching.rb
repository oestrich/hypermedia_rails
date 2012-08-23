module ActionController
  class Responder
    def to_hal
      @format = :json
      api_behavior(nil)
    end
  end
end
