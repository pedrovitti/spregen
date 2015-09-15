module Spregen
  module Helpers

    ESTIMATE_POINTS_PATTERN = /[\(\[]\d(.\d)?[\)\]]/

    def file
      @file ||= File.open("#{@source.name}-report-#{today}.md", "w")
    end

    def rprint(cards, buffer = "")
      return unless cards
      cards.each do |card|
        link = card.desc.split("\n").first || card.url
        card_name = remove_estimate_points(card.name)
        buffer << "\n" unless buffer.blank?
        buffer << " - [#{card_name}](#{link})"
      end
      buffer
    end

    def today
      Time.now.strftime("%d-%m-%Y-%M%S")
    end

    private
    def remove_estimate_points(card_title)
      card_title.gsub(ESTIMATE_POINTS_PATTERN, '')
    end
  end
end
