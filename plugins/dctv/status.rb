# encoding: utf-8

module Plugins
  module DCTV

    class Status
      include Cinch::Plugin
      include Helpers::DataLink

      set :help, <<-HELP
!whatson or !now - Display channels that are currently live.
!whatsnext or !next - Display next scheduled show.
!schedule - Display scheduled shows for the next 48 hours.
HELP

      match /whatson$/, method: :whatson
      match /now$/, method: :whatson
      def whatson(msg)
        apiResult = dctvApiJson
        onCount = 0
        apiResult.each do |result|
          unless result["Channel"] == "0"
            msg.reply "#{result["StreamName"]} is live on Channel #{result["Channel"]} - http://diamondclub.tv/##{result["Channel"]}"
            onCount += 1
          end
        end
        if onCount == 0
          msg.reply "Nothing is currently live"
        end
      end

      match /whatsnext$/, method: :whatsnext
      match /next$/, method: :whatsnext
      def whatsnext(msg)
        entries = getCalendarEntries(1)
        reply = ""
        entries.each do |entry|
          reply += "#{entry["title"]} - #{timeUntil(entry["time"])}"
        end
        msg.reply(reply)
      end

      match /schedule$/, method: :schedule
      def schedule(msg)
        entries = getCalendarEntries
        msg.reply "Here are the scheduled shows for the next 48 hours:"
        entries.each do |entry|
          if entry["time"] - 48.hours < Time.new
            msg.reply "#{entry["title"]} - #{timeIsLink(entry["time"], true)}"
          end
        end
      end
    end

  end
end
