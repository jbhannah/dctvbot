# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Tumbleweed
        include Cinch::Plugin
        include Cinch::Extensions::Authentication

        enable_authentication

        set :help, '!tumbleweed - Prints tumbleweed emoticon.'

        match /tumbleweed$/

        def execute(msg)
          msg.reply("~...~...¤")
        end
      end

    end
  end
end
