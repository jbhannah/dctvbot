# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class MitchHedberg
        include Cinch::Plugin

        match /hedberg$/

        def execute(msg)
          url = "http://en.wikiquote.org/wiki/Mitch_Hedberg"
          document = Nokogiri::HTML(open(url), nil, 'utf-8')
          quotes = document.css('li')
          quote = quotes[rand 0..quotes.length].content.strip
          msg.reply quote
        end
      end

    end
  end
end
