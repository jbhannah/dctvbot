# encoding: utf-8

module Plugins
  module DCTV

    class SecondScreenRec
      include Cinch::Plugin
      include Cinch::Extensions::Authentication

      enable_authentication

      match /secsrec on/, method: :on
      def on(m)
        m.user.notice "Second Screen Recording enabled"
      end

      match /secsrec off/, method: :off
      def off(m)
        m.user.notice "Second Screen Recording disabled"
      end
    end

  end
end
