# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Preshow
        include Cinch::Plugin
        include Cinch::Extensions::Authentication

        match /^pre\-?show\?$/i, use_prefix: false

        def execute(msg)
          return unless @bot.toys_enabled || authenticated? msg
          msg.reply("No.", true)
        end
      end

    end
  end
end
