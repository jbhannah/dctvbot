# encoding: utf-8

require 'bundler/setup'
Bundler.require

require 'cgi'
require 'net/http'
require 'open-uri'
require 'rexml/document'
require 'set'
require 'yaml'

# Helpers
require_relative 'helpers/data_link'

# Plugins
require_relative 'plugins/cleverbotredux'
require_relative 'plugins/google'
require_relative 'plugins/help'
require_relative 'plugins/wolfram'
require_relative 'plugins/dctv/notifier'
require_relative 'plugins/dctv/status'
require_relative 'plugins/dctv/toys/boiled'
require_relative 'plugins/dctv/toys/flip'
require_relative 'plugins/dctv/toys/inigo_montoya'
require_relative 'plugins/dctv/toys/mitch_hedberg'
require_relative 'plugins/dctv/toys/preshow'
require_relative 'plugins/dctv/toys/tumbleweed'
require_relative 'plugins/dctv/toys/ready'

# Other classes
require_relative 'plugins/dctv/watcher'

# Include helpers
include Helpers::DataLink

# Other includes
include REXML

bot = Cinch::Bot.new do
  configure do |c|
    config = YAML.load(File.open("config.yml"))

    # Server Info
    c.server  = config['server']['host']
    c.port    = config['server']['port']

    # Bot User Info
    c.nick      = config['bot']['nick']
    c.user      = config['bot']['user']
    c.realname  = config['bot']['realname']
    c.channels  = config['bot']['channels']

    c.authentication          = Cinch::Configuration::Authentication.new
    c.authentication.strategy = :channel_status
    c.authentication.level    = :v

    # Prefix is the bot’s name or !
    # c.plugins.prefix = lambda{ |msg| Regexp.compile("^(!|#{Regexp.escape(msg.bot.nick)}[:,]?\s*)") }

    c.plugins.plugins = [
      Cinch::Plugins::Identify,
      Plugins::CleverBotRedux,
      Plugins::Google,
      Plugins::Help,
      Plugins::Wolfram,
      Plugins::DCTV::Notifier,
      Plugins::DCTV::Status,
      Plugins::DCTV::Toys::Boiled,
      Plugins::DCTV::Toys::Flip,
      Plugins::DCTV::Toys::InigoMontoya,
      Plugins::DCTV::Toys::MitchHedberg,
      Plugins::DCTV::Toys::Preshow,
      Plugins::DCTV::Toys::Tumbleweed,
      Plugins::DCTV::Toys::Ready
    ]

    c.plugins.options = {
      Cinch::Plugins::Identify => { type: :nickserv, password: config['bot']['password'] },
      Plugins::CleverBotRedux => { defaultnick: c.nick },
      Plugins::Wolfram => { :api_id => config['plugins']['wolfram']['api'] }
    }
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
