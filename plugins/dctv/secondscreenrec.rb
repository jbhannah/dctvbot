# encoding: utf-8

module Plugins
  module DCTV

    class SecondScreenRec
      include Cinch::Plugin
      include Cinch::Extensions::Authentication

      enable_authentication

      match /secsrec on/, method: :on
      def on(m)
        @bot.record_second_screen = true
        @bot.recorded_second_screen_list.clear

        m.user.notice "Second Screen Recording enabled"
      end

      match /secsrec off/, method: :off
      def off(m)
        @bot.record_second_screen = false
        @bot.recorded_second_screen_list.clear

        m.user.notice "Second Screen Recording disabled"
      end
    end

  end
end
