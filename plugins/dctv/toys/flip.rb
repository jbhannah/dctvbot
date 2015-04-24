# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Flip
        include Cinch::Plugin
        include Cinch::Extensions::Authentication

        match /flip\s?(.*)/, method: :flip
        def flip(msg, word=nil)
          return unless (@bot.toys_enabled || authenticated?(msg))
          if word == nil || word.blank? || word =~ /table/i
            word = "┻━┻"
          else
            word = word.flip
          end
          msg.reply("(╯°□°)╯︵ #{word}")
        end

        match /unflip\s?(.*)/, method: :unflip
        def unflip(msg, word=nil)
          return unless (@bot.toys_enabled || authenticated?(msg))
          if word == nil || word.blank? || word =~ /table/i
            word = "┬───┬"
          else
            word = word.unflip
          end
          msg.reply("#{word} ノ( °_°ノ)")
        end
      end

    end
  end
end
