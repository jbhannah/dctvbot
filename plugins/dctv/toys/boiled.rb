# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Boiled
        include Cinch::Plugin
        include Cinch::Extensions::Authentication

        match /#boiled/, use_prefix: false

        def execute(msg)
          return unless (@bot.toys_enabled || authenticated?(msg))
          msg.reply Format(:bold, :white, :red, ' BBBBBOOOOOIIILLLED!! ')
        end
      end

    end
  end
end
