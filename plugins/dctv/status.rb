# encoding: utf-8

module Plugins
  module DCTV

    class Status
      include Cinch::Plugin
      include Cinch::Extensions::Authentication
      include Helpers::DataHelpers
      include Helpers::BotHelpers

      set :help, <<-HELP
!now - Display channels that are currently live.
!next - Display next scheduled show and estimated time until it starts.
!schedule - Display scheduled shows for the next 48 hours.
HELP

      match /now/, method: :now
      def now(m)
        return unless (@bot.dctv_commands_enabled || authenticated?(m))
        apiResult = dctvApiJson
        onCount = 0
        apiResult.each do |result|
          unless result["Channel"] == "0"
            m.user.notice "#{result["StreamName"]} is live on Channel #{result["Channel"]} - http://diamondclub.tv/##{result["Channel"]}"
            onCount += 1
          end
        end
        if onCount == 0
          m.user.notice "Nothing is currently live"
        end
      end

      match /next/, method: :next
      def next(m)
        return unless (@bot.dctv_commands_enabled || authenticated?(m))
        entries = getCalendarEntries(2)
        if entries[0]["time"] < Time.new
          entry = entries[1]
        else
          entry = entries[0]
        end
        title = CGI.unescape_html entry["title"]
        m.reply "Next scheduled show: #{title} (#{timeUntil(entry["time"])})"

      end

      match /schedule/, method: :schedule
      def schedule(m)
        return unless (@bot.dctv_commands_enabled || authenticated?(m))
        entries = getCalendarEntries
        m.user.notice "Here are the scheduled shows for the next 48 hours:"
        entries.each do |entry|
          if entry["time"] - 48.hours < Time.new
            title = CGI.unescape_html entry["title"]
            m.user.notice "#{title} - #{timeIsLink(entry["time"], true)}"
          end
        end
      end
    end

  end
end
