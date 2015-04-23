# encoding: utf-8

module Plugins

  class CommandControl
    include Cinch::Plugin
    include Cinch::Extensions::Authentication

    enable_authentication

    match /toyson/i, method: :enable_toys
    def enable_toys(msg)
      unless @bot.all_commands_enabled
        msg.user.notice "All commands are currently disabled"
        return
      end
      if @bot.toys_enabled
        msg.reply "Toys are already enabled"
      else
        @bot.toys_enabled = true
        msg.reply "Toys have been enabled"
      end
    end

    match /toysoff/i, method: :disable_toys
    def disable_toys(msg)
      unless @bot.all_commands_enabled
        msg.user.notice "All commands are currently disabled"
        return
      end
      if @bot.toys_enabled
        @bot.toys_enabled = false
        msg.reply "Toys have been disabled"
      else
        msg.reply "Toys are already disabled"
      end
    end

    match /dctvon/i, method: :enable_dctv
    def enable_dctv(msg)
      unless @bot.all_commands_enabled
        msg.user.notice "All commands are currently disabled"
        return
      end
      if @bot.dctv_commands_enabled
        msg.reply "DCTV actions are already enabled"
      else
        @bot.dctv_commands_enabled = true
        msg.reply "DCTV actions have been enabled"
      end
    end

    match /dctvoff/i, method: :disable_dctv
    def disable_dctv(msg)
      unless @bot.all_commands_enabled
        msg.user.notice "All commands are currently disabled"
        return
      end
      if @bot.dctv_commands_enabled
        @bot.dctv_commands_enabled = false
        msg.reply "DCTV actions have been disabled"
      else
        msg.reply "DCTV actions are already disabled"
      end
    end

    match /lockdown$/i, method: :lockdown
    def lockdown(msg)
      if @bot.all_commands_enabled
        @bot.toys_enabled = false
        @bot.dctv_commands_enabled = false
        @bot.all_commands_enabled = false
        msg.reply "All commands disabled"
      else
        msg.reply "Commands are already disabled"
      end
    end

    match /lockdownoff/i, method: :lockdown_off
    def lockdown_off(msg)
      if @bot.all_commands_enabled
        msg.reply "Commands are already enabled"
      else
        @bot.toys_enabled = true
        @bot.dctv_commands_enabled = true
        @bot.all_commands_enabled = true
        msg.reply "All commands enabled"
      end
    end
  end

end
