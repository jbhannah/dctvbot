# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Flip
        include Cinch::Plugin
        include Cinch::Extensions::Authentication

        match /flip (.+)/, method: :flipword
        def flipword(msg, word)
          return unless @bot.toys_enabled || authenticated? msg
          msg.reply("(╯°□°)╯︵ #{word.flip}")
        end

        match /flip$/, method: :fliptable
        def fliptable(msg)
          return unless @bot.toys_enabled || authenticated? msg
          msg.reply("(╯°□°)╯︵ ┻━┻")
        end
      end

    end
  end
end
