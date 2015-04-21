# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Ready
        include Cinch::Plugin

        # set :help, 'are you ready - NotPatrick is ready... are you?. May be used mid-sentance.'

        match /you ready\?/, use_prefix: false

        def execute(msg)
          msg.reply 'I was ' + Format(:bold, 'BORN') + ' ready!'
        end
      end

    end
  end
end
