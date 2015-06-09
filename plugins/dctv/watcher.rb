# encoding: utf-8

module Plugins
  module DCTV

    class Watcher
      def initialize(bot)
        @bot = bot

        results = dctvApiJson
        results.each do |result|
          @bot.official_live = true if result["Channel"] == "1"
          unless result["Channel"] == "0"
            @bot.announced << Integer(result["StreamID"])
          end
        end
      end

      def start
        while true
          sleep 10
          @bot.handlers.dispatch(:checkdctv)
        end
      end
    end

  end
end
