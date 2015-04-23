# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Ready
        include Cinch::Plugin
        include Cinch::Extensions::Authentication

        match /you ready\?/, use_prefix: false

        def execute(msg)
          return unless (@bot.toys_enabled || authenticated?(msg))
          msg.reply 'I was ' + Format(:bold, 'BORN') + ' ready!'
        end
      end

    end
  end
end
