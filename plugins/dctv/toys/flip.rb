# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Flip
        include Cinch::Plugin
        include Cinch::Extensions::Authentication

        match /flip\s?(.*)/, group: :toys, method: :flip
        def flip(m, word=nil)
          return unless (@bot.toys_enabled || authenticated?(m))
          if word == nil || word.blank? || word =~ /table/i
            word = "┻━┻"
          else
            word = word.flip
          end
          m.reply("(╯°□°)╯︵ #{word}")
        end

        match /unflip\s?(.*)/, group: :toys, method: :unflip
        def unflip(m, word=nil)
          return unless (@bot.toys_enabled || authenticated?(m))
          if word == nil || word.blank? || word =~ /table/i
            word = "┬───┬"
          else
            word = word.unflip
          end
          m.reply("#{word} ノ(°_°ノ)")
        end
      end

    end
  end
end
