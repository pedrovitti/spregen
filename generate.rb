#!/usr/bin/env ruby

require 'trello'
require 'yaml'
require 'erb'
require 'ostruct'

require_relative 'config'
require_relative 'report'

Dir[File.dirname(File.expand_path(__FILE__)) + "/lib/**/*.rb"].each { |f| require f }

unless ARGV[0]
  puts "Usage: #{$0} [board-name]"
  abort
end

Spregen::Report.new(board_name: ARGV[0]).generate
