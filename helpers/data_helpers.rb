# encoding: utf-8

require 'rexml/document'

module Helpers

  module DataHelpers
    include REXML

    def dctvApiJson
      # Returns parsed JSON from dctv api info
      url = "http://diamondclub.tv/api/status.php"
      jsonString = "["
      response = Net::HTTP.get_response(URI.parse(url))
      entries = response.body.split(/\n/)
      i = 0
      entries.each do |entry|
        entry = entry.gsub(/\{|\}/, "")
        items = entry.split(";")
        jsonString += "{"
        j = 0
        items.each do |item|
          item = item.split(":");
          jsonString += "\"#{item[0]}\":\"#{item[1]}\""
          j += 1
          jsonString += "," unless j == items.length
        end
        jsonString += "}"
        i += 1
        jsonString +="," unless i == entries.length
      end
      jsonString += "]"
      return JSON.parse(jsonString)
    end

    def getCalendarEntries(numEntries=10)
      uri = URI.parse("http://www.google.com/calendar/feeds/a5jeb9t5etasrbl6dt5htkv4to%40group.calendar.google.com/public/basic")
      params = {
        orderby: "starttime",
        singleevents:"true",
        sortorder: "ascending",
        futureevents: "true",
        ctz: "US/Eastern",
        'max-results' => "#{numEntries}"
      }
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri)
      xml = Document.new(response.body)
      response = Array.new
      xml.elements.each("feed/entry") do |entry|
        calItem = Hash.new
        entry.elements.each("title") do |title|
          calItem["title"] = title.text
        end
        entry.elements.each("content") do |content|
          content.text =~ /when:\s(.+)\sto/i
          calItem["time"] = Time.parse("#{$1} EDT")
        end
        response << calItem
      end
      return response
    end
  end

end
