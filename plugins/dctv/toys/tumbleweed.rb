# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Tumbleweed
        include Cinch::Plugin

        set :help, '!tumbleweed - Prints tumbleweed emoticon.'

        match /tumbleweed$/

        def execute(msg)
          msg.reply("~...~...¤") if powercheck(msg.channel, msg.user)
        end
      end

    end
  end
end
