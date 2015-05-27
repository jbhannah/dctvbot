# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Keywords
        include Cinch::Plugin
        include Cinch::Extensions::Authentication

        match /#boiled/, use_prefix: false, method: :boiled
        def boiled(m)
          return unless (@bot.toys_enabled || authenticated?(m))
          m.reply Format(:bold, :white, :red, ' BBBBBOOOOOIIILLLED!! ')
        end

        match /inconceivable/i, use_prefix: false, method: :inconceivable
        def inconceivable(m)
          return unless (@bot.toys_enabled || authenticated?(m))
          m.reply("You keep using that word. I do not think it means what you think it means.")
        end

        match /(inigo|montoya)/i, use_prefix: false, method: :inigomontoya
        def inigomontoya(m)
          return unless (@bot.toys_enabled || authenticated?(m))
          m.reply("Hello. My name is Inigo Montoya. You killed my father. Prepare to die.")
        end

        match /pre[\-\s]?show\?/i, use_prefix: false, method: :preshow
        def preshow(m)
          return unless (@bot.toys_enabled || authenticated?(m))
          m.reply("No.", true)
        end

        match /you ready?/i, use_prefix: false, method: :ready
        def ready(m)
          return unless (@bot.toys_enabled || authenticated?(m))
          m.reply 'I was ' + Format(:bold, 'BORN') + ' ready!'
        end

        match /pa{3,}nts/i, use_prefix: false, method: :pants
        def pants(m)
          return unless (@bot.toys_enabled || authenticated?(m))
          m.reply 'skirr'
        end
      end

    end
  end
end
