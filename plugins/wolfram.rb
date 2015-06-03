# encoding: utf-8

module Plugins

  class Wolfram
    include Cinch::Plugin
    include Cinch::Extensions::Authentication
    include Helpers::BotHelpers

    set :help, '!wolfram <query> - Attempts to answer your <query> using Wolfram Alpha'

    match /wolfram (.+)/

    def execute(m, query)
      return unless (@bot.search_enabled || authenticated?(msg))
      m.reply search(query)
    end

    def search(query)
      wolfram = WolframAlpha::Client.new(config[:api_id], options = { :timeout => 30 })
      response = wolfram.query query
      input = response["Input"] # Get the input interpretation pod.
      # result = response.find { |pod| pod.title == "Result" }
      result = response.pods[1] # unless result
      output = ""
      if result
        result.subpods.each do |subpod|
          output += "#{subpod.plaintext} "
        end
        output = Cinch::Toolbox.truncate(output.strip, 300)
        reply = "#{input.subpods[0].plaintext}\n"
        reply += output.gsub("  ", " ][ ")
        reply += "\nMore Info: https://www.wolframalpha.com/input/?i=#{query.gsub(" ","+")}"
      else
        "Sorry, I've no idea. Does this help? https://www.wolframalpha.com/input/?i=#{query.gsub(" ","+")}"
      end
    end
  end

end
