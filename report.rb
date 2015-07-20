require_relative 'board'
require_relative 'burndown'
require_relative 'helpers'

module Spregen
  class Report
    include Spregen::Helpers

    attr_accessor :report

    def initialize(configuration = {})
      @source = Spregen::Board.new(configuration)
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
      "Report #{@source.name}"
    end

    def not_done
      buffer = ''
      rprint @source.doing_cards, buffer
      rprint @source.todo_cards, buffer
    end

    def done
      rprint @source.done_cards
    end

    def bugs
      rprint @source.bug_cards
    end
  end
end
