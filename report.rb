require_relative 'board'
require_relative 'burndown'
require_relative 'helpers'

module Spregen
  class Report

    include Spregen::Helpers

    attr_accessor :report

    def initialize(configuration = {})
      Spregen::Config.configure_trello_client
      @board = Spregen::Board.new(configuration[:board_name])
    end

    def generate
      file.write print_report
      file.close
    end

    def generate_burndown
      burndown = Spregen::Burndown.new({})
      burndown.generate
    end

    def print_report
      Spregen::Template.build(binding)
    end

    def source
      self
    end

    def title
      "Report #{@board.name}"
    end

    def not_done
      buffer = ""
      rprint @board.doing_cards, buffer
      rprint @board.todo_cards, buffer
    end

    def done
      rprint @board.done_cards
    end

    def bugs
      rprint @board.bug_cards
    end

  end
end