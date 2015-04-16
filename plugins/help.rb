# encoding: utf-8

module Plugins

  class Help
    include Cinch::Plugin

    set :help, 'help [name] - prints information about a command (or all commands with no name specified). Responds though private message only.'

    # match /help (\w+)/, method: :with_name
    match /help$/, method: :without_name
    match /^help (\w+)/, use_prefix: false, react_on: :private, method: :with_name
    match /^help$/, use_prefix: false, react_on: :private, method: :without_name

    def with_name(m, query)
      active, help_available = false
      help = ""
      @bot.plugins.find { |plugin|
        if plugin.class.plugin_name == query
          active = true
          help = plugin.class.help
          help_available = !help.nil?
        end
      }
      if !active || !help_available
        result = active ? 'No help available.' : 'No active plugin. Type help for list of available plugins.'
        m.user.send(result)
      else
        m.user.send(help)
      end
    end

    def without_name(m)
      plugin_names = []
      @bot.plugins.each { |plugin| plugin_names << plugin.class.plugin_name unless plugin.class.help.nil? }
      m.user.send "Active plugins: #{plugin_names.join(', ')}"
    end
  end

end
