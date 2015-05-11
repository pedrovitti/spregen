#!/usr/bin/env ruby

require 'trello'
require 'yaml'
require 'erb'
require 'ostruct'

module Spregen
  class Report

    attr_reader :today, :board_name
    attr_accessor :report

    def initialize(configuration = {})
      @board_name = configuration[:board_name]
      @today = Time.now.strftime("%d-%m-%Y-%M%S")
      configure_trello_client
    end

    def generate
      @report = File.new("#{board_name}-report-#{today}.md", "w")
      print_report
      report.close
    end

    def print_report
      report.puts Spregen::Template.build(binding)
    end

    def source
      self
    end

    def lists
      @lists ||= board.lists
    end

    def board
      @board ||= Trello::Board.all.find { |x| x.name == @board_name }
    end

    def bug_cards
      @bug_cards ||= done_cards.find_all { |card| card.name =~ /\[BUG\]/i }
    end

    def done_cards
      @done_cards ||= get_cards(/^\[DONE\]/)
    end

    def qa_cards
      @qa_cards ||= get_cards(/^\[Q\.A\]/)
    end

    def doing_cards
      @doing_cards ||= get_cards(/^\[DOING\]/)
    end

    def todo_cards
      @todo_cards ||= get_cards(/^\[TODO\]/)
    end

    def burndown
    end

    def title
      "Report #{@board_name}"
    end

    def not_done
      buffer = ""
      rprint doing_cards, buffer
      rprint todo_cards, buffer
    end

    def done
      rprint done_cards
    end

    def bugs
      rprint bug_cards
    end

    def get_cards(list_name)
      card_list = lists.detect { |list| list.name =~ list_name }

      card_list.cards.reject do |card|
        card.labels.find { |label| label.name == 'Skip Report' }
      end
    end

    def rprint(cards, buffer = "")
      cards.each do |card|
        link = card.desc.split("\n").first || card.url
        buffer << "\n" unless buffer.blank?
        buffer << " - [#{card.name}](#{link})"
      end
      buffer
    end

    def configure_trello_client
      trello_config = YAML.load_file('config.yml')["trello"]
      Trello.configure do |config|
        config.developer_public_key = trello_config["api_key"]
        config.member_token = trello_config["member_token"]
      end
    end
  end
end
Dir[File.dirname(File.expand_path(__FILE__)) + "/lib/**/*.rb"].each { |f| require f }

unless ARGV[0]
  puts "Usage: #{$0} [board-name]"
  abort
end

Spregen::Report.new(board_name: ARGV[0]).generate
