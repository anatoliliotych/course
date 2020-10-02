# frozen_string_literal: true

app_files = File.expand_path('app/**/*.rb', __dir__)
Dir.glob(app_files).sort.each { |file| require(file) }

require './middleware/middleware'
