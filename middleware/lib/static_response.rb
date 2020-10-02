# frozen_string_literal: true

module Course
  module StaticResponse
    def prepare_response(file_path, status = 200)
      response = Rack::Response.new
      file_data = File.read(file_path)
      response.headers.merge!('Content-Type' => 'text/html')
      response.status = status
      response.write(file_data)
      response.finish
    end
  end
end
