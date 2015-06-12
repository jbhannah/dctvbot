# encoding: utf-8

module Plugins
  module DCTV

    class Notifier
      include Cinch::Plugin
      include Helpers::DataHelpers

      listen_to :checkdctv

      def listen(m)
        statuses = dctvApiJson
        if @bot.official_live
          official_check = false
          statuses.each do |status|
            official_check = true if status["Channel"] == "1"
          end
          @bot.official_live = official_check
          update_topic("<>") unless @bot.official_live
        end
        return if @bot.official_live
        statuses.each do |stream|
          id = Integer(stream["StreamID"])
          if stream["Channel"] != "0" && stream["Alerts"] == "true" && !@bot.announced.include?(id)
            channel = stream["Channel"]
            channelLink = "http://diamondclub.tv/##{channel}"
            live = Format(:white, :red, " LIVE ")
            Channel(@bot.channels[0]).send(Format(:bold, "#{stream["StreamName"]} is #{live} on Channel #{channel} - #{channelLink} "))
            @bot.announced << id
            if stream["Channel"] == "1"
              @bot.official_live = true
              update_topic("LIVE: #{stream["StreamName"]} #{channelLink}")
            end
          elsif stream["Channel"] == "0" && @bot.announced.include?(id)
            @bot.announced.delete(id)
          end
        end
      end

      private

        def update_topic(title)
          topic_array = Channel(@bot.channels[0]).topic.split("|")
          topic_array.shift
          new_topic = title + " |" + topic_array.join("|")
          Channel(@bot.channels[0]).topic = new_topic
        end
    end

  end
end
