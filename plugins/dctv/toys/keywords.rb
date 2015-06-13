# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class Keywords
        include Cinch::Plugin
        include Cinch::Extensions::Authentication

        match /#boiled/, group: :toys, use_prefix: false, method: :boiled
        def boiled(m)
          return unless @bot.toys_enabled
          m.reply Format(:bold, :white, :red, ' BBBBBOOOOOIIILLLED!! ')
        end

        match /pre[\-\s]?show[\?!\.]?/i, group: :toys, use_prefix: false, method: :preshow
        def preshow(m)
          return unless @bot.toys_enabled
          if m.user.nick == "Beef"
            m.reply "DAMMIT BEEF!"
          else
            m.reply 'No.', true
          end
        end

        match /you ready\?/i, group: :toys, use_prefix: false, method: :ready
        def ready(m)
          return unless (@bot.toys_enabled || authenticated?(m))
          m.reply 'I was ' + Format(:bold, 'BORN') + ' ready!'
        end

        match /pa{3,}nts/i, group: :toys, use_prefix: false, method: :pants
        def pants(m)
          return unless @bot.toys_enabled
          m.reply 'skirr'
        end

        match /anthony carboni/i, group: :toys, use_prefix: false, method: :carboni
        def carboni(m)
          return unless @bot.toys_enabled
          m.reply 'oooOOOOoooOOooo'
        end
      end

    end
  end
end
