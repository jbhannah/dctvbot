# encoding: utf-8

module Plugins
  module DCTV

    class Status
      include Cinch::Plugin
      include Cinch::Extensions::Authentication
      include Helpers::DataHelpers
      include Helpers::BotHelpers

      set :help, <<-HELP
!now [v] - Display channels that are currently live. Voiced and higher users can specify the v option to have it show in main chat.
!next - Display next scheduled show and estimated time until it starts.
!schedule [v] - Display scheduled shows for the next 48 hours via user notice. Voiced and higher users can specify the v option to have it show in main chat.
HELP

      match /now\s?\-{0,2}(v?)(?:erbose)?/, method: :now
      def now(m, flag=nil)
        return unless (@bot.dctv_commands_enabled || authenticated?(m))
        response = Net::HTTP.get_response(URI.parse('http://diamondclub.tv/api/channelsv2.php'))
        apiResult = JSON.parse(response.body)['assignedchannels']
        onCount = 0
        output = ""
        apiResult.each do |result|
          unless result['yt_upcoming']
            output += "#{result['friendlyalias']} is live on Channel #{result['channel']} - #{result['urltoplayer']}\n"
            onCount += 1
          end
        end
        if onCount == 0
          output = "Nothing is currently live"
        end

        if flag == "v" && authenticated?(m)
          m.reply output
        else
          m.user.notice output
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

      match /schedule\s?\-{0,2}(v?)(?:erbose)?/, method: :schedule
      def schedule(m, flag=nil)
        return unless (@bot.dctv_commands_enabled || authenticated?(m))
        entries = getCalendarEntries
        output =  "Here are the scheduled shows for the next 48 hours:"
        entries.each do |entry|
          if entry["time"] - 48.hours < Time.new
            title = CGI.unescape_html entry["title"]
            output += "\n#{title} - #{timeIsLink(entry["time"], true)}"
          end
        end
        if flag == "v" && authenticated?(m)
          m.reply output
        else
          m.user.notice output
        end
      end
    end

  end
end
