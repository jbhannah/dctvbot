# encoding: utf-8
# Adapted from https://github.com/curiouslyExistential/cinch-cleverbotredux

module Plugins

	class CleverBotRedux
		include Cinch::Plugin
		include Cinch::Extensions::Authentication

		set :help, <<-HELP
!disablechatter - Disables the bot's CleverBot interface. Voiced or higher only.
!enablechatter - Re-enables the bot's CleverBot interface. Voiced or higher only.
HELP

		match lambda { |m| /^#{m.bot.nick}[:,]?\s*(.+)/i }, use_prefix: false
		match /disablechatter$/, method: :disableChanChat
		match /enablechatter$/, method: :enableChanChat

		def initialize(*args)
			super
			@defaultnick = config[:defaultnick] || "cleverBot"
			@prefixUse = true
			@disabledChannels = Set.new
			@cleverbot = Cleverbot::Client.new
		end

		def execute(m, message)
			return if @disabledChannels.include?(m.channel)
			if m.channel
				msg_back = @cleverbot.write message
				m.reply(msg_back, @prefixUse)
			end
		end

		def disableChanChat(m, message)
			return unless authenticated? m
			if @disabledChannels.add?(m.channel) == nil
				tosend = "CleverBot already disabled."
			else
				tosend = "CleverBot disabled."
				@disabledChannels + ["#{m.channel}"]
			end
			m.reply(tosend, @prefixUse)
		end

		def enableChanChat(m, message)
			return unless authenticated? m
			if @disabledChannels.delete?(m.channel) == nil
				tosend = "CleverBot already enabled."
			else
				tosend = "CleverBot enabled."
				@disabledChannels - ["#{m.channel}"]
			end
			m.reply(tosend, @prefixUse)
		end
	end

end
