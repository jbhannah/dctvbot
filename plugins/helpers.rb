# encoding: utf-8

module Plugins
  module Helpers

    def timeIsLink(time, includeDay=false, timezone='US/Eastern')
      time = time.in_time_zone(timezone)
      return "http://time.is/#{time.strftime("%H%M_%Z")}" unless includeDay
      return "http://time.is/#{time.strftime("%H%M_%d_%b_%Y_%Z")}"
    end
    
  end
end
