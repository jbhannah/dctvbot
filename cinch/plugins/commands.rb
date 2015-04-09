require 'rexml/document'
require 'active_support/time'

include REXML

module Cinch
  module Plugins
    class Commands
      include Cinch::Plugin

      match /whatson/, method: :whatson
      match /whatsnext/, method: :whatsnext

      set :help, <<-HELP
cinch whatson
  I'll tell you what's currently streaming
cinch whatsnext
  I'll figure out what's coming up next and let you know
  HELP

      def whatson(msg)
        apiResult = DctvAPI.getJson
        onCount = 0
        apiResult.each do |result|
          unless Integer(result["Channel"]) == 0
            msg.reply "#{result["StreamName"]} is live on Channel #{result["Channel"]} - http://diamondclub.tv/##{result["Channel"]}"
            onCount += 1
          end
        end
        if onCount == 0
          msg.reply "Nothing is currently live"
        end
      end

      def whatsnext(msg)
        reply = "Next Scheduled Show: "
        uri = URI.parse("http://www.google.com/calendar/feeds/a5jeb9t5etasrbl6dt5htkv4to%40group.calendar.google.com/public/basic")
        params = {
          orderby: "starttime",
          singleevents:"true",
          sortorder: "ascending",
          futureevents: "true",
          'max-results' => "1"
        }
        uri.query = URI.encode_www_form(params)
        response = Net::HTTP.get_response(uri)
        xml = Document.new(response.body)
        xml.elements.each("feed/entry") do |entry|
          entry.elements.each("title") do |title|
            reply += " #{title.text}"
          end
          entry.elements.each("content") do |content|
            content.text =~ /when:\s(.*)\sto/i
            time = Time.parse("#{$1} MDT")
            time = time.in_time_zone('US/Eastern')
            reply += " - http://time.is/#{time.strftime("%H%M")}_ET"
          end
        end
        msg.reply(reply)
      end
    end
  end
end
