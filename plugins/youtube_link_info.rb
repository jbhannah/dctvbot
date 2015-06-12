# encoding: utf-8

module Plugins

  class YoutubeLinkInfo
    include Cinch::Plugin

    match /\s?(https?:\/\/(?:www\.)?youtu(?:\.be|be.com)\/.+)\s?/, use_prefix: false

    def execute(m, url)
      document = Nokogiri::HTML(open(url), nil, 'utf-8')
      title = document.at('title').text
      description = document.at('meta[name="description"]')[:content]
      m.reply Cinch::Toolbox.truncate("#{title} - #{description}", 300)
    end
  end

end
