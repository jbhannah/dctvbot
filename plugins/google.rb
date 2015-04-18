# encoding: utf-8

module Plugins

  class Google
    include Cinch::Plugin

    set :help, '!google <term> - Returns top hit on google when searching for <term>'

    match /google (.+)/

    def execute(msg, prefix, query)
      msg.reply(search(query))
    end

    def search(query)
      url = "http://www.google.com/search?q=#{CGI.escape(query)}"
      document = Nokogiri::HTML(open(url), nil, 'utf-8')

      title = document.at_css('h3.r a').content.strip
      link = document.at_css('cite').content.strip
      unless link =~ /^https/i
        link = "http://#{link}"
      end
      CGI.unescape_html "#{title} [#{link}]"
    # rescue
    #   "No results found"
    end
  end

end
