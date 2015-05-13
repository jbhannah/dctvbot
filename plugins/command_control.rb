# encoding: utf-8

module Plugins

  class CommandControl
    include Cinch::Plugin
    include Cinch::Extensions::Authentication

    enable_authentication

    match /toyson/i, method: :enable_toys
    def enable_toys(m)
      @bot.toys_enabled = enable_command_set(m, @bot.toys_enabled, "Toy commands")
    end

    match /toysoff/i, method: :disable_toys
    def disable_toys(m)
      @bot.toys_enabled = disable_command_set(m, @bot.toys_enabled, "Toy commands")
    end

    match /chatteron/i, method: :enable_cleverbot
		def enable_cleverbot(m)
      @bot.cleverbot_enabled = enable_command_set(m, @bot.cleverbot_enabled, "Cleverbot interfaces")
		end

    match /chatteroff/i, method: :disable_cleverbot
    def disable_cleverbot(m)
      @bot.cleverbot_enabled = disable_command_set(m, @bot.cleverbot_enabled, "Cleverbot interfaces")
		end

    match /searchon/i, method: :enable_search
    def enable_search(m)
      @bot.search_enabled = enable_command_set(m, @bot.search_enabled, "Search commands")
    end

    match /searchoff/i, method: :disable_search
    def disable_search(m)
      @bot.search_enabled = disable_command_set(m, @bot.search_enabled, "Search commands")
    end

    match /dctvon/i, method: :enable_dctv
    def enable_dctv(m)
      @bot.dctv_commands_enabled = enable_command_set(m, @bot.dctv_commands_enabled, "DCTV commands")
    end

    match /dctvoff/i, method: :disable_dctv
    def disable_dctv(m)
      @bot.dctv_commands_enabled = disable_command_set(m, @bot.dctv_commands_enabled, "DCTV commands")
    end

    match /lockdown$/i, method: :lockdown
    def lockdown(m)
      if @bot.all_commands_enabled
        @bot.toys_enabled = false
        @bot.cleverbot_enabled = false
        @bot.search_enabled = false
        @bot.dctv_commands_enabled = false
        @bot.all_commands_enabled = false
        m.user.notice "All commands disabled"
      else
        m.user.notice "Commands are already disabled"
      end
    end

    match /lockdownoff/i, method: :lockdown_off
    def lockdown_off(m)
      if @bot.all_commands_enabled
        m.user.notice "Commands are already enabled"
      else
        @bot.toys_enabled = true
        @bot.cleverbot_enabled = true
        @bot.search_enabled = true
        @bot.dctv_commands_enabled = true
        @bot.all_commands_enabled = true
        m.user.notice "All commands enabled"
      end
    end

    private

      def disable_command_set(m, command_set_boolean, command_set_name)
        unless @bot.all_commands_enabled
          m.user.notice "All commands are currently disabled"
          return
        end
        if command_set_boolean
          m.user.notice "#{command_set_name} have been disabled"
        else
          m.user.notice "#{command_set_name} are already disabled"
        end
        return false
      end

      def enable_command_set(m, command_set_boolean, command_set_name)
        unless @bot.all_commands_enabled
          m.user.notice "All commands are currently disabled"
          return
        end
        if command_set_boolean
          m.user.notice "#{command_set_name} are already enabled"
        else
          m.user.notice "#{command_set_name} have been enabled"
        end
        return true
      end
  end

end
