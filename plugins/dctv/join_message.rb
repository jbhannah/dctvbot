# encoding: utf-8

module Plugins
  module DCTV

    class JoinMessage
      include Cinch::Plugin
      include Cinch::Extensions::Authentication

      def initialize(*args)
        super
        @current_join_msg = "We welcome everyone here in chatrealm and ask that any TWiT drama stay in the #drama room"
        @do_msg = false
      end

      listen_to :join
      def listen(m)
        if @do_msg
          m.user.notice @current_join_msg
        end
      end

      match /setjoin (.+)/
      def execute(m, input)
        return unless authenticated?(m)
        if input == "off"
          @do_msg = false
          m.user.notice "Join message is now off"
        elsif input == "on"
          @do_msg = true
          m.user.notice "Join message is now on"
        else
          @current_join_msg = input
          m.user.notice "Join message has been changed to: #{@current_join_msg}"
        end
      end
    end

  end
end
