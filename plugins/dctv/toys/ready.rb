# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Ready
        include Cinch::Plugin
        include Cinch::Extensions::Authentication

        enable_authentication

        set :help, 'are you ready - NotPatrick is ready... are you?. May be used mid-sentance.'

        match /are you ready/, use_prefix: false

        def execute(msg)
          msg.reply('I WAS BORN READY!')
        end
      end

    end
  end
end
