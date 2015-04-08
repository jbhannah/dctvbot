require "bundler/setup"
Bundler.require

# Require Plugins
require_relative "plugins/commands"
require_relative "plugins/dctvapi"
require_relative "plugins/help"
require_relative "plugins/notifier"
require_relative "plugins/quit"
require_relative "plugins/watcher"

bot = Cinch::Bot.new do
  configure do |c|
    # Server Info
    c.server  = "irc.chatrealm.net"
    c.port    = 6667

    # Bot User Info
    c.nick = "dctvbot"
    c.user = "dctvbot"
    c.realname = "dctvbot"
    c.channels = ["#testinn"]

    # Plugin Options

    # Prefix is the bot’s name
    c.plugins.prefix = lambda{ |msg| Regexp.compile("^#{Regexp.escape(msg.bot.nick)}:?\s*") }

    config.plugins.options[Cinch::Quit] = {
      :op => true
    }

    # Plugins to load
    c.plugins.plugins = [Cinch::Quit, Cinch::Help, DctvApi, Notifier, Commands]
  end

  trap "SIGINT" do
    bot.log("Caught SIGINT, quitting...", :info)
    bot.quit
  end

  trap "SIGTERM" do
    bot.log("Caught SIGTERM, quitting...", :info)
    bot.quit
  end
end

Thread.new { Watcher.new(bot).start }
bot.start
