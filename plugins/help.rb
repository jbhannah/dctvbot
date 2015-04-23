# encoding: utf-8

module Plugins

  class Help
    include Cinch::Plugin

    set :help, '!help - Prints available commands and their descriptions. Responds though private message.'

    match /help/

    def execute(m)
      m.user.send "Readme: https://github.com/tinnvec/dctvbot/blob/master/readme.md"
      m.user.send "Available commands:"
      @bot.plugins.each do |plugin|
        m.user.send plugin.class.help unless plugin.class.help.nil?
      end
    end
  end

end
