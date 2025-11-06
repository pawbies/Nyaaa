# frozen_string_literal: true

module Melo
  class Item
    attr_accessor :name, :type, :from, :to

    def initialize(options = {}, defaults = {})
      @name = options[:name]
      @type = options[:type] || defaults[:type] || "sym"
      @from = options[:from]
      @to   = options[:to]
    end

    def apply
      File.link @from, @to if @type == "hard"
      File.symlink @from, @to if @type == "sym"
    rescue Errno::EPERM => e
      # you cannot create hard links to directories
      puts "#{@name} failed to link: #{e.message}"
    rescue Errno::EEXIST => e
      puts "#{@name} failed to link: #{e.message}"
    end

    def bash_line
      return "ln #{@from} #{@to} ##{@name}" if @type == "hard"
      return "ln -s #{@from} #{@to} ##{@name}" if @type == "sym"

      "# something went wrong with #{@name}"
    end
  end
end
