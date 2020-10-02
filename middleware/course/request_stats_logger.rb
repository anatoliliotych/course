# frozen_string_literal: true

module Course
  class RequestStatsLogger
    attr_reader :logger

    def initialize(app, logger = ::Logger.new($stdout))
      @logger = logger
      @app = app
    end

    def call(env)
      env['rack.logger'] = logger
      started_on = Time.now
      processing_started_at = current_process_time
      @app.call(env).tap do |response|
        log(env, response, started_on, processing_started_at)
      end
    end

    private

    def log(env, response, started_on, processing_started_at)
      path = env['PATH_INFO']
      status = response[0]
      response_time = (current_process_time - processing_started_at).round(4)
      logger.info "[#{started_on}] Request to '#{path}' started" if response[0] == 200
      logger.info "[#{Time.now}] Request to '#{path}' finished with response status #{status} in #{response_time} ms"
    end

    def current_process_time
      Process.clock_gettime(Process::CLOCK_MONOTONIC) * 1000
    end
  end
end
