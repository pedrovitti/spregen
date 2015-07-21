#!/usr/bin/env ruby

require 'trello'
require 'yaml'
require 'erb'
require 'ostruct'
require 'commander/import'

require_relative 'config'
require_relative 'report'

Dir[File.dirname(File.expand_path(__FILE__)) + '/lib/**/*.rb'].each { |f| require f }

if $PROGRAM_NAME == __FILE__

  Spregen::Config.configure_trello_client

  program :name, 'Spregen'
  program :version, '0.0.1'
  program :description, 'Generate Sprint Reports from your Trello board.'

  command :generate do |c|
    c.syntax = 'spregen generate board'
    c.description = 'Generate the report'
    c.action do |args, _|
      fail 'You have to specify the board name' unless args.first
      Spregen::Report.new(board_name: args.first).generate
    end
  end
end
