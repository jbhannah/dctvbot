class Watcher
  def initialize(bot)
    @bot = bot
  end

  def start
    while true
      sleep 15
      @bot.handlers.dispatch(:checkdctv, nil, @bot.channels[0])
    end
  end
end
