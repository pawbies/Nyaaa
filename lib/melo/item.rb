# frozen_string_literal: true

module Melo
  class Item # rubocop:disable Style/Documentation
    attr_accessor :name, :type, :from, :to

    def initialize(options = {}, defaults = {})
      @name = options[:name]
      @type = options[:type] || defaults[:type] || "sym"
      @from = options[:from]
      @to   = options[:to]

      @exit_on_error = options[:exit_on_error] || defaults[:exit_on_error] || false
    end

    def apply
      File.link @from, @to if @type == "hard"
      File.symlink @from, @to if @type == "sym"
    rescue Errno::EPERM => e
      warn "#{@name} failed to link: #{e.message}"
      exit e.errno if @exit_on_error
    rescue Errno::EEXIST => e
      warn "#{@name} failed to link: #{e.message}"
      exit e.errno if @exit_on_error
    end

    def bash_line
      return "ln #{@from} #{@to} ##{@name}" if @type == "hard"
      return "ln -s #{@from} #{@to} ##{@name}" if @type == "sym"

      "# something went wrong with #{@name}"
    end
  end
end
