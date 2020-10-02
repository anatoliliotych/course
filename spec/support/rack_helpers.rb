# frozen_string_literal: true

module RackHelpers
  def request_env_for(path)
    Rack::MockRequest.env_for(path)
  end
end
