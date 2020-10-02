# frozen_string_literal: true

require './boot'
require './app'

use Course::RequestStatsLogger
use Course::ErrorStatusHandler
use Course::Static
use Course::Rescuer
run Course::App.new
