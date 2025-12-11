# frozen_string_literal: true

require "thor"

require_relative "config"

module Nyaaa
  class CLI < Thor
    desc "init", "Generate a config file in the current directory"
    def init
      File.write(File.join(Dir.pwd, "nyaaa.yml"), Config.generate_sample_config)
    end

    desc "link", "Link to configurations as defined in the nyaaa.yml file"
    def link
      config = Config.new "nyaaa.yml"
      config.items.each(&:apply)
    end

    desc "gen", "Generate bash script to apply the changes"
    def gen
      config = Config.new "nyaaa.yml"
      File.write(File.join(Dir.pwd, "nyaaa.sh"), config.generate_bash_script)
    end
  end
end
