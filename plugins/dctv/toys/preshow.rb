# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Preshow
        include Cinch::Plugin

        match /^pre\-?show\?$/i, use_prefix: false

        def execute(msg)
          msg.reply("No.", true)
        end
      end

    end
  end
end
