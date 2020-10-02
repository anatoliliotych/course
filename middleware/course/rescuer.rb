# frozen_string_literal: true

module Course
  class Rescuer
    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env)
    rescue StandardError => e
      logger = env['rack.logger']
      logger.info "[#{Time.now}] Request to '#{env['PATH_INFO']}' failed with exception #{e.message}"
      logger.info "Backtrace: #{e.backtrace}"
      failed
    end

    private

    def failed
      [500, {}, '']
    end
  end
end
