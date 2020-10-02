# frozen_string_literal: true

module Course
  class Router
    def initialize(request)
      @request = request
    end

    def route!
      if @request.path == '/'
        [200, { 'content-type' => 'text/plain' }, ['Hello world']]
      else
        not_found
      end
    end

    private

    def not_found
      [404, {}, '']
    end
  end
end
