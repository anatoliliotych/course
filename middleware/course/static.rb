# frozen_string_literal: true

module Course
  class Static
    include Course::StaticResponse

    def initialize(app)
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)
      @req_path = req.path
      if @req_path =~ /public/
        return prepare_response(file_path) if file_exists?

        [404, {}, '']
      else
        @app.call(env)
      end
    end

    def file_exists?
      File.exist?(file_path)
    end

    def file_path
      Rack::Directory.new('').root + @req_path
    end
  end
end
