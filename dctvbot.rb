# encoding: utf-8

require 'bundler/setup'
Bundler.require

require 'net/http'
require 'rexml/document'
require 'active_support/time'

# Require Plugins
require_relative 'cinch/plugins/commands'
require_relative 'cinch/plugins/help'
require_relative 'cinch/plugins/notifier'

include REXML

class DctvAPI
  def self.getJson
    # Returns parsed JSON from dctv api info
    url = "http://diamondclub.tv/api/status.php"
    jsonString = "["
    response = Net::HTTP.get_response(URI.parse(url))
    entries = response.body.split(/\n/)
    i = 0
    entries.each do |entry|
      entry = entry.gsub(/\{|\}/, "")
      items = entry.split(";")
      jsonString += "{"
      j = 0
      items.each do |item|
        item = item.split(":");
        jsonString += "\"#{item[0]}\":\"#{item[1]}\""
        j += 1
        unless j == items.length
          jsonString += ","
        end
      end
      jsonString += "}"
      i += 1
      unless i == entries.length
        jsonString +=","
      end
    end
    jsonString += "]"
    return JSON.parse(jsonString)
  end

  def self.calendarEntries(numEntries)
    calendarTz = "MDT"
    uri = URI.parse("http://www.google.com/calendar/feeds/a5jeb9t5etasrbl6dt5htkv4to%40group.calendar.google.com/public/basic")
    params = {
      orderby: "starttime",
      singleevents:"true",
      sortorder: "ascending",
      futureevents: "true",
      'max-results' => "#{numEntries}"
    }
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)
    xml = Document.new(response.body)
    response = Array.new
    xml.elements.each("feed/entry") do |entry|
      calItem = Hash.new
      entry.elements.each("title") do |title|
        calItem["title"] = title.text
      end
      entry.elements.each("content") do |content|
        content.text =~ /when:\s(.*)\sto/i
        calItem["time"] = Time.parse("#{$1} #{calendarTz}")
      end
      response << calItem
    end
    return response
  end

  def self.timeIsLinkEastern(time)
    time = time.in_time_zone('US/Eastern')
    return "http://time.is/#{time.strftime("%H%M")}_ET"
  end

  def self.timeIsLinkEasternDay(time)
    time = time.in_time_zone('US/Eastern')
    return "http://time.is/#{time.strftime("%H%M_%d_%b_%Y")}_ET"
  end
end

class Watcher
  def initialize(bot)
    @bot = bot
  end

  def start
    while true
      sleep 15
      @bot.handlers.dispatch(:checkdctv, nil, @bot)
    end
  end
end

def spamcheck?
  if @lastspam.nil? || @lastspam + 5.minutes < Time.new
    @lastspam = Time.new
    return false
  else
    return true
  end
end

bot = Cinch::Bot.new do
  configure do |c|
    # Server Info
    c.server  = "irc.chatrealm.net"
    c.port    = 6667

    # Bot User Info
    c.nick = "dctvbot"
    c.user = "dctvbot"
    c.realname = "dctvbot"
    c.channels = ["#chat"]

    # Prefix is the bot’s name
    c.plugins.prefix = lambda{ |msg| Regexp.compile("^(!|#{Regexp.escape(msg.bot.nick)}(?:,|:)?\s*)") }

    c.plugins.plugins = [
      Cinch::Plugins::Help,
      Cinch::Plugins::Notifier,
      Cinch::Plugins::Commands
    ]
  end

  on :message, /#boiled/i do |msg|
    unless spamcheck?
      msg.reply("\u0002\x0300,04 BBBBBOOOOOIIILLLED!! ")
    end
  end

  on :message, /anthony\scarboni/i do |msg|
    unless spamcheck?
      msg.reply("oooooOOOOOooooOOooo")
    end
  end

  on :message, /^preshow\?$/i do |msg|
    unless spamcheck?
      msg.reply("No.", true)
    end
  end

  on :message, /pizza/i do |msg|
    unless spamcheck?
      msg.reply("pizzaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
    end
  end

  on :message, /tableflip/i do |msg|
    unless spamcheck?
      msg.reply("(╯°□°)╯︵ ┻━┻")
    end
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
results = DctvAPI.getJson
results.each do |result|
  unless Integer(result["Channel"]) == 0
    bot.announced << Integer(result["StreamID"])
  end
end

Thread.new { Watcher.new(bot).start }
bot.start
