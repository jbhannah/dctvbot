module Cinch
  module Plugins
    class ThatsWhatSheSaid
      include Cinch::Plugin

      listen_to :message, :method => :twss

      set :help, <<-HELP
no commands
  This plugin will attempt to catch twss jokes
  HELP

      def twss(m, *args)
        TWSS.threshold = 10.0
        if TWSS(m.message)
          m.reply "#{m.user.nick}: That's what she said!"
        end
      end
    end
  end
end
