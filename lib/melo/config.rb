# frozen_string_literal: true

require "yaml"
require_relative "item"

module Melo
  class Config
    attr_accessor :settings, :defaults, :items

    SAMPLE_CONFIG = <<~YML
      defaults:
        type: hard #you cannot create hard links to directories
        exit_on_error: false

      items:
        melo:
          from: melo.yml
          to: copy.yml
          type: sym
    YML

    def initialize(file_path)
      @defaults = {}
      @items = []

      file = File.open(file_path, "r")
      config = YAML.load(file.read)

      parse_defaults config["defaults"]
      parse_items    config["items"]
    end

    def generate_bash_script
      script = "#!/bin/sh\n"

      items.each do |item|
        script += item.bash_line
        script += "\n"
      end

      script
    end

    private

    def parse_defaults(defaults)
      @defaults[:type] = %w[sym hard].include?(defaults["type"]) ? defaults["type"] : nil
      @defaults[:exit_on_error] = [true, false].include?(defaults["exit_on_error"]) ? defaults["exit_on_error"] : nil
    end

    def parse_items(items)
      items.each do |name, settings|
        settings = settings.transform_keys(&:to_sym)
        @items.push(Item.new({ name: name, **settings }, @defaults))
      end
    end
  end
end
