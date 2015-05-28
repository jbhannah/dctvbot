# encoding: utf-8

module Plugins
  module DCTV

    class SecondScreen
      include Cinch::Plugin
      include Cinch::Extensions::Authentication

      enable_authentication

      match /secs (.+)/

      def execute(m, url)
        if url == "off" && @bot.record_second_screen
          # Disable second screen recording
          @bot.record_second_screen = false
          @bot.recorded_second_screen_list.clear
          return
        end

        if @bot.record_second_screen
          @bot.recorded_second_screen_list.push(url)
        end

        response = HTTParty.get("http://diamondclub.tv/api/secondscreen.php?url=#{url}&pro=4938827&user=#{m.user.nick}")
        m.user.notice "Command Sent. Response: #{response}"
      end
    end

  end
end
