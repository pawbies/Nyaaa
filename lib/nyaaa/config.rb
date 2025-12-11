# frozen_string_literal: true

require "yaml"
require_relative "item"
require_relative "default_configs"

module Nyaaa
  class Config
    attr_accessor :settings, :defaults, :items

    SAMPLE_CONFIG = <<~YML
      defaults:
        type: hard #you cannot create hard links to directories
        exit_on_error: false

      items:
        nyaaa:
          from: nyaaa.yml
          to: copy.yml
          type: sym
    YML

    def initialize(file_path)
      @defaults = {}
      @items = []

      file = File.open(file_path, "r")
      config = YAML.load(file.read)

      if config.nil?
        puts "Config file doesnt exist or is empty"
        exit 1
      end

      if config["defaults"].nil?
        @config = nil
      else
        parse_defaults config["defaults"]
      end
      if config["items"].nil?
        @items = []
      else
        parse_items config["items"]
      end
    end

    def generate_bash_script
      script = "#!/bin/sh\n"

      items.each do |item|
        script += item.bash_line
        script += "\n"
      end

      script
    end

    def self.generate_sample_config
      sample_config = SAMPLE_CONFIG

      Dir.foreach(".") do |name|
        next if [".", ".."].include?(name)

        DEFAULT_CONFIGS.each do |key, config|
          next unless config[:folders].include?(name)

          sample_config += <<~ITEM
            #{key}:
              from: #{name}
              to: #{config[:to]}
              type: #{config[:type]}
          ITEM
        end
      end

      sample_config
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
