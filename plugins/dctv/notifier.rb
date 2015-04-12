# encoding: utf-8

module Plugins
  module DCTV

    class Notifier
      include Cinch::Plugin
      include Plugins::DCTV::DataLink

      listen_to :checkdctv

      def listen(m, bot)
        statuses = dctvApiJson
        statuses.each do |stream|
          id = Integer(stream["StreamID"])
          if stream["Channel"] != "0" && stream["Alerts"] == "true" && !bot.announced.include?(id)
            channel = stream["Channel"]
            channelLink = "http://diamondclub.tv/##{channel}"
            live = Format(:white, :red, "LIVE")
            Channel(bot.channels[0]).send(Format(:bold, "#{stream["StreamName"]} is #{live} on Channel #{channel} - #{channelLink}"))
            bot.announced << id
          elsif stream["Channel"] == "0" && bot.announced.include?(id)
            bot.announced.delete(id)
          end
        end
      end
    end

  end
end
