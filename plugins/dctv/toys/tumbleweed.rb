# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Tumbleweed
        include Cinch::Plugin
        include Cinch::Extensions::Authentication

        match /tumbleweed/

        def execute(m)
          return unless (@bot.toys_enabled || authenticated?(m))
          m.reply("~...~...¤")
        end
      end

    end
  end
end
