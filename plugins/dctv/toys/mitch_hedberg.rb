# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class MitchHedberg
        include Cinch::Plugin
        include Cinch::Extensions::Authentication

        match /hedberg/

        def execute(m)
          return unless (@bot.toys_enabled || authenticated?(m))
          url = "http://en.wikiquote.org/wiki/Mitch_Hedberg"
          document = Nokogiri::HTML(open(url), nil, 'utf-8')
          quotes = document.css('li')
          quotes = clean_non_quotes(quotes.to_a)
          quote = quotes[rand 0..quotes.length].content.strip
          m.reply quote
        end

        private

          def clean_non_quotes(li_nodeset)
            li_nodeset.each do |li|
              if li.at_css('a') || li.content =~ /^track\s\d+/i
                li_nodeset.delete(li)
              end
            end
            return li_nodeset
          end
      end

    end
  end
end
