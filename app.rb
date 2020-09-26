# frozen_string_literal: true

module Course
  class App
    def call(_env)
      [200, { 'Content-Type' => 'text/html' }, ['Hello world']]
    end
  end
end
