# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Boiled
        include Cinch::Plugin
        include Cinch::Extensions::Authentication

        enable_authentication

        set :help, '#boiled - You just got boiled. May be used mid-sentance.'

        match /#boiled/, use_prefix: false

        def execute(msg)
          msg.reply Format(:bold, :white, :red, ' BBBBBOOOOOIIILLLED!! ')
        end
      end

    end
  end
end
