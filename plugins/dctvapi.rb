require "net/http"

class Cinch::DctvApi
  include Cinch::Plugin

  match /status/

  def execute(msg)
    msg.reply getStatus
  end

  private

    def getStatus()
      url = "http://diamondclub.tv/api/status.php"
      jsonString = "["
      response = Net::HTTP.get_response(URI.parse(url))
      data = response.body.split(/\n/)
      i = 0
      data.each do |line|
        line = line.gsub("{", "")
        line = line.gsub("}", "")
        line = line.split(";")
        jsonString += "{"
        j = 0
        line.each do |item|
          item = item.split(":");
          jsonString += "\"#{item[0]}\":\"#{item[1]}\""
          j = j + 1
          unless j == line.length
            jsonString += ","
          end
        end
        jsonString += "}"
        i = i + 1
        unless i == data.length
          jsonString +=","
        end
      end
      jsonString += "]"
      return JSON.parse(jsonString)
    end
end
