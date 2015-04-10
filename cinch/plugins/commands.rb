# encoding: utf-8

require 'rexml/document'
require 'active_support/time'

include REXML

module Cinch
  module Plugins
    class Commands
      include Cinch::Plugin

      set :help, <<-HELP
!whatson
  What's currently streaming
!whatsnext
  What will be on next
!schedule
  Scheduled shows that will be on in the next 48 hours
  HELP

      def timeIsLinkEastern(time)
        time = time.in_time_zone('US/Eastern')
        return "http://time.is/#{time.strftime("%H%M")}_ET"
      end

      def timeIsLinkEasternDay(time)
        time = time.in_time_zone('US/Eastern')
        return "http://time.is/#{time.strftime("%H%M_%d_%b_%Y")}_ET"
      end

      def powercheck(channel, user)
        return false unless channel.opped?(user) || channel.half_opped?(user) || channel.voiced?(user)
        return true
      end

      match /whatson/, method: :whatson
      def whatson(msg)
        apiResult = DctvAPI.getJson
        onCount = 0
        apiResult.each do |result|
          unless Integer(result["Channel"]) == 0
            msg.reply "#{result["StreamName"]} is live on Channel #{result["Channel"]} - http://diamondclub.tv/##{result["Channel"]}"
            onCount += 1
          end
        end
        if onCount == 0
          msg.reply "Nothing is currently live"
        end
      end

      match /whatsnext/, method: :whatsnext
      def whatsnext(msg)
        entries = DctvAPI.calendarEntries(1)
        reply = "Next Scheduled Show: "
        entries.each do |entry|
          reply += entry["title"]
          reply += " - "
          reply += timeIsLinkEastern(entry["time"])
        end
        msg.reply(reply)
      end

      match /schedule/, method: :schedule
      def schedule(msg)
        entries = DctvAPI.calendarEntries(10)
        msg.reply ("Here are the scheduled shows for the next 48 hours:")
        entries.each do |entry|
          if entry["time"] - 48.hours < Time.new
            reply = entry["title"]
            reply += " - "
            reply += timeIsLinkEasternDay(entry["time"])
            msg.reply(reply)
          end
        end
      end

      match /boil/i, method: :boil
      def boil(msg)
        if msg.channel && powercheck(msg.channel, msg.user)
          msg.reply("\u0002\x0300,04 BBBBBOOOOOIIILLLED!! ")
        end
      end

      match /flip/i, method: :tableflip
      def tableflip(msg)
        if msg.channel && powercheck(msg.channel, msg.user)
          msg.reply("(╯°□°)╯︵ ┻━┻")
        end
      end

      match /tumbleweed/i, method: :tumbleweed
      def tumbleweed(msg)
        if msg.channel && powercheck(msg.channel, msg.user)
          msg.reply("~...~...¤")
        end
      end
    end
  end
end
