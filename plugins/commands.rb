class Commands
  include Cinch::Plugin

  match /whoson/, method: :whoson

  set :help, <<-HELP
cinch whoson
  I'll tell you what's currently streaming
  HELP

  def whoson(msg)
    apiResult = DctvApi.getJson
    onCount = 0
    apiResult.each do |result|
      unless Integer(result["Channel"]) == 0
        msg.reply "#{result["StreamName"]} is live on Channel #{result["Channel"]}"
        onCount += 1
      end
    end
    if onCount == 0
      msg.reply "Nothing is currently live"
    end
  end
end
