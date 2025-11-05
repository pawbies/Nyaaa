# frozen_string_literal: true

require "thor"

module Melo
  class CLI < Thor
    desc "init", "Generate a config file in the current directory"
    def init
      sample = <<~YML
        settings:
          ignore_errors: true

        defaults:
          type: sym

        items:
          one:
            from: one
            to: ".config/one"
            type: hard
          two:
            from: two
            to: ~/.two
      YML

      File.write(File.join(Dir.pwd, "melo.yml"), sample)
    end
  end
end
