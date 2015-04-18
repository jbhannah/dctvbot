# encoding: utf-8

module Plugins
  module DCTV
    module Toys

      class InigoMontoya
        include Cinch::Plugin

        # set :help, '!tumbleweed - Prints tumbleweed emoticon.'

        match /inconceivable$/i, use_prefix: false, method: :inconceivable
        match /(inigo|montoya)/i, use_prefix: false, method: :inigomontoya

        def inconceivable(msg)
          msg.reply("You keep using that word. I do not think it means what you think it means.")
        end

        def inigomontoya(msg)
          msg.reply("Hello. My name is Inigo Montoya. You killed my father. Prepare to die.")
        end
      end

    end
  end
end
