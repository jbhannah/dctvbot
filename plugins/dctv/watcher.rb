# encoding: utf-8

module Plugins
  module DCTV

    class Watcher
      def initialize(bot)
        @bot = bot
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
