# encoding: utf-8

module Plugins

  class Help
    include Cinch::Plugin

    match /help/
    match /help/, use_prefix: false, react_on: :private

    def execute(m)
      m.user.send "Readme: https://github.com/tinnvec/dctvbot/blob/master/readme.md"
      m.user.send "Available commands:"
      @bot.plugins.each do |plugin|
        m.user.send plugin.class.help unless plugin.class.help.nil?
      end
    end
  end

end
