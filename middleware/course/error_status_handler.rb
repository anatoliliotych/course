# frozen_string_literal: true

module Course
  class ErrorStatusHandler
    include Course::StaticResponse

    STATUS_MAPPING_TO_FILE = {
      404 => 'public/404.html',
      500 => 'public/500.html'
    }.freeze

    def initialize(app)
      @app = app
    end

    def call(env)
      status, = response = @app.call(env)
      case status
      when 404, 500
        prepare_response(STATUS_MAPPING_TO_FILE[status], status)
      else
        response
      end
    end
  end
end
