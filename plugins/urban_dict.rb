# encoding: utf-8

module Plugins

  class UrbanDict
    include Cinch::Plugin
    include Cinch::Extensions::Authentication

    set :help, '!urban <term> - Returns result of Urban Dictionary search for <term>'

    match /urban (.+)/

    def execute(m, query)
      return unless (@bot.search_enabled || authenticated?(m))
      m.reply search(query)
    end

    def search(query)
      url = "http://www.urbandictionary.com/define.php?term=#{CGI.escape(query)}"
      document = Nokogiri::HTML(open(url), nil, 'utf-8')
      word = CGI.unescape_html(document.css(".word").first.content.strip)
      definition = Cinch::Toolbox.truncate(CGI.unescape_html(document.css(".meaning").first.content.strip), 300)
      example = CGI.unescape_html(document.css(".example").first.content.strip)
      "#{word}: #{definition} - #{url}\nExample: #{example}"
    rescue
      "No results found - #{url}"
    end
  end

end
