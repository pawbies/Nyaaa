# frozen_string_literal: true

require_relative "melo/version"
require_relative "melo/config"
require_relative "melo/cli"
require_relative "melo/item"

module Melo
  class Error < StandardError; end
end
