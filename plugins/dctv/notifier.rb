# encoding: utf-8

module Plugins
  module DCTV

    class Notifier
      include Cinch::Plugin
      include Helpers::DataHelpers

      listen_to :checkdctv

      def initialize(*args)
        super
        response = Net::HTTP.get_response(URI.parse('http://diamondclub.tv/api/channelsv2.php'))
        results = JSON.parse(response.body)['assignedchannels']
        results.each do |result|
          @bot.official_live = true if !result['yt_upcoming'] && result['channel'] == 1
          unless result['nowonline'] == "no"
            @bot.announced << Integer(result['streamid'])
          end
        end
      end

      def listen(m)
        response = Net::HTTP.get_response(URI.parse('http://diamondclub.tv/api/channelsv2.php'))
        statuses = JSON.parse(response.body)['assignedchannels']
        if @bot.official_live
          official_check = false
          statuses.each do |status|
            official_check = true if !status['yt_upcoming'] && status['channel'] == 1
          end
          @bot.official_live = official_check
          update_topic("<>") unless @bot.official_live
        end
        return if @bot.official_live
        statuses.each do |stream|
          id = Integer(stream['streamid'])
          if !stream['yt_upcoming'] && stream['alerts'] && !@bot.announced.include?(id)
            channel = stream['channel']
            channelLink = "http://dctv.link/#{channel}"
            live = Format(:white, :red, " LIVE ")
            msg = "#{stream['friendlyalias']}"
            msg += " [#{stream['twitch_yt_description']}]" unless stream['twitch_yt_description'].blank?
            msg += " is #{live} on Channel #{stream['channel']} - #{stream['urltoplayer']} "
            Channel(@bot.channels[0]).send(Format(:bold, msg))
            @bot.announced << id
            if stream['channel'] == 1
              @bot.official_live = true
              topic = "LIVE: #{stream['friendlyalias']}"
              topic += " - #{stream['twitch_yt_description']}" unless stream['twitch_yt_description'].blank?
              topic += " - #{stream['urltoplayer']}"
              update_topic(topic)
            end
          elsif !stream['yt_upcoming'] && !stream['nowonline'] && @bot.announced.include?(id)
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
