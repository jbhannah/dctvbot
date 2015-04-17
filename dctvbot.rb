# encoding: utf-8

require 'bundler/setup'
Bundler.require

require 'net/http'
require 'rexml/document'
require 'set'

# Helpers
require_relative 'helpers/data_link'

# Plugins
require_relative 'plugins/cleverbotredux'
require_relative 'plugins/help'
require_relative 'plugins/dctv/notifier'
require_relative 'plugins/dctv/status'
require_relative 'plugins/dctv/toys/boiled'
require_relative 'plugins/dctv/toys/flip'
require_relative 'plugins/dctv/toys/preshow'
require_relative 'plugins/dctv/toys/tumbleweed'

# Other classes
require_relative 'plugins/dctv/watcher'

# Include helpers
include Helpers::DataLink

# Other includes
include REXML

bot = Cinch::Bot.new do
  configure do |c|
    # Server Info
    c.server  = "irc.chatrealm.net"
    c.port    = 6667

    # Bot User Info
    c.nick      = "dctvbot"
    c.user      = "dctvbot"
    c.realname  = "dctvbot"
    c.channels  = ["#chat"]

    c.authentication          = Cinch::Configuration::Authentication.new
    c.authentication.strategy = :channel_status
    c.authentication.level    = :v

    # Prefix is the bot’s name or !
    c.plugins.prefix = lambda{ |msg| Regexp.compile("^(!|#{Regexp.escape(msg.bot.nick)}[:,]?\s*)") }

    c.plugins.options = {
      Plugins::CleverBotRedux => {
        :pesternetwork  => false,
        :defaultnick    => c.nick
      }
    }

    c.plugins.plugins = [
      Plugins::CleverBotRedux,
      Plugins::Help,
      Plugins::DCTV::Notifier,
      Plugins::DCTV::Status,
      Plugins::DCTV::Toys::Boiled,
      Plugins::DCTV::Toys::Flip,
      Plugins::DCTV::Toys::Preshow,
      Plugins::DCTV::Toys::Tumbleweed
    ]
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

class << bot
  attr_accessor :announced
end
bot.announced = Array.new
results = dctvApiJson
results.each do |result|
  unless Integer(result["Channel"]) == 0
    bot.announced << Integer(result["StreamID"])
  end
end

Thread.new { Plugins::DCTV::Watcher.new(bot).start }
bot.start
