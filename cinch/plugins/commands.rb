require 'rexml/document'
require 'active_support/time'

include REXML

module Cinch
  module Plugins
    class Commands
      include Cinch::Plugin

      match /whatson/, method: :whatson
      match /whatsnext/, method: :whatsnext
      match /schedule/, method: :schedule

      set :help, <<-HELP
cinch whatson
  I'll tell you what's currently streaming
cinch whatsnext
  I'll figure out what's coming up next and let you know
cinch schedule
  I'll tell you the next 5 shows on the schedule
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
        entries = DctvAPI.calendarEntries(1)
        reply = "Next Scheduled Show: "
        entries.each do |entry|
          reply += entry["title"]
          reply += " - "
          reply += DctvAPI.timeIsLinkEastern(entry["time"])
        end
        msg.reply(reply)
      end

      def schedule(msg)
        entries = DctvAPI.calendarEntries(5)
        msg.reply ("Here are the next 5 scheduled shows:")
        entries.each do |entry|
          reply = entry["title"]
          reply += " - "
          reply += DctvAPI.timeIsLinkEasternDay(entry["time"])
          msg.reply(reply)
        end
      end
    end
  end
end
