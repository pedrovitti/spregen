#!/usr/bin/env ruby

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
    @report = File.new("#{board_name}-report-#{today}.md", "w")
    print_report
    report.close
  end

  def print_report
    title
    burndown
    overview
    not_done
    done
    bugs
    retrospective
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

  private

  def burndown
    report.puts("\n### Sprint Burndown")
    report.puts("\n### Release Burndown")
  end

  def overview
    report.puts("\n### Overview")
  end

  def title
    report.puts("### Report - #{@board_name}")
  end

  def retrospective
    report.puts("\n#### Retrospectiva")
    report.puts("**Negativos**")
    report.puts("**Positivos**")
  end

  def not_done
    report.puts("\n### Not Done")
    rprint doing_cards
    rprint todo_cards
  end

  def done
    report.puts("\n### Done")
    rprint done_cards
  end

  def bugs
    report.puts("\n### Bugs")
    rprint bug_cards
  end

  def get_cards(list_name)
    lists.detect { |list| list.name =~ list_name }.cards
  end

  def rprint(cards)
    cards.each do |card|
      link = card.desc.split("\n").blank? ? card.url : card.desc.split("\n").first
      report.puts(" - [#{card.name}](#{link})")
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
