# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Flip
        include Cinch::Plugin
        include Cinch::Extensions::Authentication

        enable_authentication

        match /flip (.+)/, method: :flipword
        match /flip$/, method: :fliptable

        def flipword(msg, word)
          msg.reply("(╯°□°)╯︵ #{word.flip}")
        end

        def fliptable(msg)
          msg.reply("(╯°□°)╯︵ ┻━┻")
        end
      end

    end
  end
end
