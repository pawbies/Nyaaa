# frozen_string_literal: true

require "thor"

require_relative "config"

module Melo
  class CLI < Thor
    desc "init", "Generate a config file in the current directory"
    def init
      File.write(File.join(Dir.pwd, "melo.yml"), Config::SAMPLE_CONFIG)
    end

    desc "link", "Link to configurations as defined in the melo.yml file"
    def link
      config = Config.new "melo.yml"
      config.items.each(&:apply)
    end

    desc "gen", "Generate bash script to apply the changes"
    def gen
      config = Config.new "melo.yml"
      File.write(File.join(Dir.pwd, "melo.sh"), config.generate_bash_script)
    end
  end
end
