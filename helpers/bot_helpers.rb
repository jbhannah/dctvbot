# encoding: utf-8

module Helpers

  module BotHelpers
    def timeIsLink(time, includeDay=false, timezone='US/Eastern')
      time = time.in_time_zone(timezone)
      return "http://time.is/#{time.strftime("%H%M_%Z")}" unless includeDay
      return "http://time.is/#{time.strftime("%H%M_%d_%b_%Y_%Z")}"
    end

    def timeUntil(time, timezone='US/Eastern')
      time = time.in_time_zone(timezone)
      differenceInSeconds = (time - Time.new).round
      return differenceInSeconds.seconds.to_time_sentence
    end
  end

end
