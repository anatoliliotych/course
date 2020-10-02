# frozen_string_literal: true

require './boot'
require './app'
require 'rack/cache'

use Rack::Cache, { metastore: 'file:./tmp/cache/rack/meta', entitystore: 'file:./tmp/cache/rack/body', verbose: true }
use Course::RequestStatsLogger
use Course::ErrorStatusHandler
use Course::Static
use Course::Rescuer
run Course::App.new
