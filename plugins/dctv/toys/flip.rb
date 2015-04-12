# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Flip
        include Cinch::Plugin
        include Cinch::Extensions::Authentication

        enable_authentication

        set :help, '!flip [word] - Table flip emoticon. If [word] is supplied, the table is replaced with [word].'

        match /flip (.+)/, method: :flipword
        match /flip$/, method: :fliptable

        def flipword(msg, prefix, word)
          msg.reply("(╯°□°)╯︵ #{flipString(word)}")
        end

        def fliptable(msg)
          msg.reply("(╯°□°)╯︵ ┻━┻")
        end
      end

    end
  end
end
