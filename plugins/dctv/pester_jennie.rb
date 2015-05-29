# encoding: utf-8

module Plugins
  module DCTV

    class PesterJennie
      include Cinch::Plugin

      listen_to :join
      def listen(m)
        current_time = Time.now.in_time_zone('US/Pacific')
        return unless m.user.nick == "jenniej23"
        @message_timer = Timer(60) do
          if (current_time.hour <= 11 || current_time.hour >= 2) && @message_timer.started
            @message_timer.stop
            next
          end
          next unless current_time.hour >= 12 && current_time.hour <= 2
          m.user.send "Have you tweeted about DTNS and given beatmaster the links?"
        end
        @message_timer.start
      end

      match /got it/, use_prefix: false, react_on: :private
      def execute(m)
        return unless m.user.nick == "jenniej23" && @message_timer.started
        @message_timer.stop
        m.user.send "Awesome, have a great show!"
      end
    end

  end
end
