class Notifier
  include Cinch::Plugin

  listen_to :checkdctv

  def listen(m, outputChannel)
    statuses = DctvApi.getJson

    statuses.each do |stream|
      if stream["Channel"] != "0" && stream["Alerts"] == "true"
        Channel(outputChannel).send("#{stream["StreamName"]} is LIVE on Channel #{stream["Channel"]}")
      elsif stream["Alerts"] == "true"
        bot.log("#{stream["StreamName"]} is NOT live", :info)
      else
        bot.log("#{stream["StreamName"]} will NOT be alerted", :info)
      end
    end
  end
end
