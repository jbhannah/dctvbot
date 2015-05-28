# encoding: utf-8

module Plugins
  module DCTV

    class PesterJennie
      include Cinch::Plugin

      listen_to :join
      def listen(m)
        return unless m.user.nick == "jenniej23"
        @message_timer = Timer(60) do
          current_time = Time.now.in_time_zone('US/Pacific')
          break unless current_time.hour > 12 && current_time.hour < 3
          m.user.send "Have you tweeted about DTNS and given beatmaster the links?"
        end
      end

      match /got it/, use_prefix: false, react_on: :private
      def execute(m)
        return unless m.user.nick == "jenniej23"
        @message_timer.stop
        m.user.send "Awesome, have a great show!"
      end

    end

  end
end
