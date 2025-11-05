# frozen_string_literal: true

require "yaml"
require_relative "item"

module Melo
  class Config
    attr_accessor :settings, :defaults, :items

    def initialize(file_path)
      @settings = {}
      @defaults = {}
      @items = []

      @file = File.open(file_path, "r")
      config = YAML.load(@file.read)

      parse_settings config["settings"]
      parse_defaults config["defaults"]
      parse_items    config["items"]
    end

    def parse_settings(settings)
      @settings[:ignore_errors] = [true, false].include?(settings["ignore_errors"]) ? settings["ignore_errors"] : nil
    end

    def parse_defaults(defaults)
      @defaults[:type] = %w[sym hard].include?(defaults["type"]) ? defaults["type"] : nil
    end

    def parse_items(items)
      items.each do |name, settings|
        settings = settings.transform_keys(&:to_sym)
        @items.push(Item.new({ name: name, **settings }, @defaults))
      end
    end
  end
end
