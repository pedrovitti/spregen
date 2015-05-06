#!/usr/bin/env ruby

require 'date'
require 'trello'
require 'yaml'

class Report
  attr_reader :today, :board_name
  attr_accessor :report

  def initialize(configuration = {})
    @board_name = configuration[:board_name]
    @today = Time.now.strftime("%d-%m-%Y-%M%S")
    configure_trello_client
  end

  def generate
    get_cards

    self.report = File.new("#{board_name}-report-#{today}.md", "w")

    self.report.puts("### Sprint Report")
    self.report.puts("### Overview")

    not_done
    done
    bugs
    retrospective

    report.close
  end

  private
  def retrospective
    self.report.puts("\n#### Retrospectiva")
    self.report.puts("**Negativos**")
    self.report.puts("**Positivos**")
  end

  def not_done
    self.report.puts("\n### Not Done")
    @doing_cards.each { |card| self.report.puts(" - #{card.name}") }
    @todo_cards.each { |card| self.report.puts(" - #{card.name}") }
  end

  def done
    self.report.puts("\n### Done")
    @done_cards.each { |card| self.report.puts(" - #{card.name}") }
  end

  def bugs
    report.puts("\n### Bugs")
    @done_cards.each do |card|
      report.puts(" - #{card.name}") if bug?(card)
    end
  end

  def bug?(card)
    card.name =~ /\[BUG\]/i
  end

  def get_cards
    board = Trello::Board.all.find { |x| x.name == @board_name }
    board.lists.each do |list|
      case list.name
      when /^\[DONE\]/
        @done_cards = list.cards
      when /^\[Q\.A\]/
        @qa_cards = list.cards
      when /^\[DOING\]/
        @doing_cards = list.cards
      when /^\[TODO\]/
        @todo_cards = list.cards
      end
    end
  end

  def configure_trello_client
    trello_config = YAML.load_file('config.yml')["trello"]
    Trello.configure do |config|
      config.developer_public_key = trello_config["api_key"]
      config.member_token = trello_config["member_token"]
    end
  end
end

unless ARGV[0]
  puts "Usage: #{$0} [board-name]"
  abort
end

Report.new(board_name: ARGV[0]).generate
