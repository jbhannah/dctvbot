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
require_relative 'helpers/data_helpers'
require_relative 'helpers/bot_helpers'

# Plugins
require_relative 'plugins/clevererbot'
require_relative 'plugins/command_control'
require_relative 'plugins/google'
require_relative 'plugins/help'
require_relative 'plugins/wikipedia'
require_relative 'plugins/wolfram'
require_relative 'plugins/dctv/join_message.rb'
require_relative 'plugins/dctv/notifier'
require_relative 'plugins/dctv/pester_jennie'
require_relative 'plugins/dctv/second_screen'
require_relative 'plugins/dctv/status'
require_relative 'plugins/dctv/toys/flip'
require_relative 'plugins/dctv/toys/keywords'
require_relative 'plugins/dctv/toys/mitch_hedberg'
require_relative 'plugins/dctv/toys/tumbleweed'

# Other classes
require_relative 'plugins/dctv/watcher'

# Include helpers
include Helpers::DataHelpers
include Helpers::BotHelpers

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

    c.plugins.plugins = [
      Cinch::Plugins::Identify,
      Plugins::ClevererBot,
      Plugins::CommandControl,
      Plugins::Google,
      Plugins::Help,
      Plugins::Wikipedia,
      Plugins::Wolfram,
      Plugins::DCTV::JoinMessage,
      Plugins::DCTV::Notifier,
      Plugins::DCTV::PesterJennie,
      Plugins::DCTV::SecondScreen,
      Plugins::DCTV::Status,
      Plugins::DCTV::Toys::Flip,
      Plugins::DCTV::Toys::Keywords,
      Plugins::DCTV::Toys::MitchHedberg,
      Plugins::DCTV::Toys::Tumbleweed
    ]

    c.plugins.options = {
      Cinch::Plugins::Identify => { type: :nickserv, password: config['bot']['password'] },
      Plugins::Wikipedia => { max_length: 300 },
      Plugins::Wolfram => { wolfram_api_key: config['plugins']['wolfram']['api'] },
      Plugins::DCTV::SecondScreen => { pastebin_api_key: config['plugins']['pastebin']['api'] }
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
  attr_accessor :announced, :official_live, :toys_enabled, :cleverbot_enabled,
                :search_enabled, :dctv_commands_enabled, :all_commands_enabled,
                :recorded_second_screen_list
end
bot.announced = Array.new
bot.official_live = false
bot.toys_enabled = true
bot.cleverbot_enabled = true
bot.search_enabled = true
bot.dctv_commands_enabled = true
bot.all_commands_enabled = true
bot.recorded_second_screen_list = Array.new

results = dctvApiJson
results.each do |result|
  bot.official_live = true if result["Channel"] == "1"
  unless result["Channel"] == "0"
    bot.announced << Integer(result["StreamID"])
  end
end

Thread.new { Plugins::DCTV::Watcher.new(bot).start }
bot.start
