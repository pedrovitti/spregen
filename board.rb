module Spregen
  class Board
    attr_accessor :name

    def initialize(configuration)
      self.name = configuration[:board_name]
    end

    def lists
      @lists ||= board.lists
    end

    def board
      @board ||= Trello::Board.all.find { |x| x.name == self.name }
    end

    def bug_cards
      @bug_cards ||= done_cards.find_all { |card| card.name =~ /\[BUG\]/i } if done_cards
    end

    def done_cards
      @done_cards ||= get_cards(/^\[DONE\]/i)
    end

    def qa_cards
      @qa_cards ||= get_cards(/^\[Q\.A\.\]/i)
    end

    def doing_cards
      @doing_cards ||= get_cards(/^\[DOING\]/i)
    end

    def todo_cards
      @todo_cards ||= get_cards(/^\[TODO\]/i)
    end

    private

    def get_cards(list_name)
      card_list = lists.detect { |list| list.name =~ list_name }
      return unless card_list.present?
      card_list.cards.reject do |card|
        card.labels.find { |label| label.name == 'Skip Report' }
      end
    end
  end
end
