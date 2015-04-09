module Cinch
  module Plugins
    class Notifier
      include Cinch::Plugin

      listen_to :checkdctv

      def listen(m, bot)
        statuses = DctvAPI.getJson

        statuses.each do |stream|
          id = Integer(stream["StreamID"])
          if stream["Channel"] != "0" && stream["Alerts"] == "true" && !bot.announced.include?(id)
            Channel(bot.channels[0]).send("#{stream["StreamName"]} is \u0002\x0300,04LIVE\x0F on Channel #{stream["Channel"]} - http://diamondclub.tv/##{stream["Channel"]}")
            bot.announced << id
          elsif stream["Channel"] == "0" && bot.announced.include?(id)
            bot.log("#{stream["StreamName"]} is no longer live", :info)
            bot.announced.delete(id)
          end
        end
      end
    end
  end
end
