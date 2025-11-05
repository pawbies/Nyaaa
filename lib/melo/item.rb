# frozen_string_literal: true

module Melo
  class Item
    attr_accessor :name, :type, :from, :to

    def initialize(options = {}, defaults = {})
      @name = options[:name]
      @type = options[:type] || defaults[:type]
      @from = options[:from]
      @to   = options[:to]
    end

    def apply
      puts "#{@name} is being handled"
    end
  end
end
