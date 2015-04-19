# encoding: utf-8

module Plugins

  class Wolfram
    include Cinch::Plugin

    set :help, '!wolfram <term> - Returns top hit on google when searching for <term>'

    match /wolfram (.+)/

    def execute(m, query)
      m.reply search(query)
    end

    def search(query)
      wolfram = WolframAlpha::Client.new(config[:api_id], options = { :timeout => 1 } )
      response = wolfram.query(query)
      result = parse_response response
      if result
        result
      else
        "Sorry, I've no idea"
      end
    end

    def parse_response(response)
      pod = response.find { |pod| pod.title == "Result" }
      pod = response.pods[1] if pod.nil?
      pod.subpods[0].plaintext
    end

  end

end
