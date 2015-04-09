require 'rexml/document'
require 'active_support/time'

include REXML

module Cinch
  module Plugins
    class Commands
      include Cinch::Plugin





      set :help, <<-HELP
cinch whatson
  I'll tell you what's currently streaming
cinch whatsnext
  I'll tell you what will be on next
cinch schedule
  I'll tell you the shows that will be on in the next 48 hours
  HELP

      match /whatson/, method: :whatson
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

      match /whatsnext/, method: :whatsnext
      def whatsnext(msg)
        entries = DctvAPI.calendarEntries(1)
        reply = "Next Scheduled Show: "
        entries.each do |entry|
          reply += entry["title"]
          reply += " - "
          reply += DctvAPI.timeIsLinkEastern(entry["time"])
        end
        msg.reply(reply)
      end

      match /schedule/, method: :schedule
      def schedule(msg)
        entries = DctvAPI.calendarEntries(10)
        msg.reply ("Here are the scheduled shows for the next 48 hours:")
        entries.each do |entry|
          if entry["time"] - 48.hours < Time.new
            reply = entry["title"]
            reply += " - "
            reply += DctvAPI.timeIsLinkEasternDay(entry["time"])
            msg.reply(reply)
          end
        end
      end
    end
  end
end
