# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class MitchHedberg
        include Cinch::Plugin

        match /hedberg/, group: :toys

        def execute(m)
          return unless @bot.toys_enabled
          url = "http://www.buzzfeed.com/mrloganrhoades/a-complete-ranking-of-almost-every-single-mitch-hedberg-joke"
          document = Nokogiri::HTML(open(url), nil, 'utf-8')
          potential_quotes = document.css('.buzz_superlist_item_wide p')
          quotes = Array.new
          potential_quotes.each do |quote|
            if quote.text =~ /^\d/
              quote = quote.inner_html.gsub(/^\d{1,3}\.\s/, '')
              quote = quote.gsub(/\[<a href="(.+)">Listen<\/a>\]$/) { |s| $1 }
              quotes << quote.strip
            end
          end
          quote = CGI.unescape_html(quotes[rand 0..quotes.length])
          m.reply quote
        end
      end

    end
  end
end
