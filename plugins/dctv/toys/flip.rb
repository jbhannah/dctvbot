# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Flip
        include Cinch::Plugin

        set :help, '!flip [word] - Table flip emoticon. If [word] is supplied, the table is replaced with [word].'

        match /flip (.+)/, method: :flipword
        match /flip$/, method: :fliptable

        def flipword(msg, prefix, word)
          msg.reply("(╯°□°)╯︵ #{flipString(word)}") if powercheck(msg.channel, msg.user)
        end

        def fliptable(msg)
          msg.reply("(╯°□°)╯︵ ┻━┻") if powercheck(msg.channel, msg.user)
        end
      end

    end
  end
end
