require "net/http"

class DctvApi
  include Cinch::Plugin

  def self.getJson
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
        unless j == items.length
          jsonString += ","
        end
      end
      jsonString += "}"
      i += 1
      unless i == entries.length
        jsonString +=","
      end
    end
    jsonString += "]"
    return JSON.parse(jsonString)
  end
end
