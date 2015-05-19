module Spregen
  module Helpers

    def file
      @file ||= File.open("#{@board.name}-report-#{today}.md", "w")
    end

    def rprint(cards, buffer = "")
      return unless cards
      cards.each do |card|
        link = card.desc.split("\n").first || card.url
        buffer << "\n" unless buffer.blank?
        buffer << " - [#{card.name}](#{link})"
      end
      buffer
    end

    def today
      Time.now.strftime("%d-%m-%Y-%M%S")
    end

  end

end