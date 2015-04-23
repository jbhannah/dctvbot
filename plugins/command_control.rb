# encoding: utf-8

module Plugins

  class CommandControl
    include Cinch::Plugin
    include Cinch::Extensions::Authentication

    enable_authentication

    match /toyson/i, method: :enable_toys
    def enable_toys(msg)
      if @bot.toys_enabled
        msg.reply "Toys are already enabled"
      else
        @bot.toys_enabled = true
        msg.reply "Toys have been enabled"
      end
    end

    match /toysoff/i, method: :disable_toys
    def disable_toys(msg)
      if @bot.toys_enabled
        @bot.toys_enabled = false
        msg.reply "Toys have been disabled"
      else
        msg.reply "Toys are already disabled"
      end
    end
  end

end
