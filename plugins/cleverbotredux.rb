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
		match(/<c=\d{1,3},\d{1,3},\d{1,3}>.{2}: CB: (.+)/ , use_prefix: false)
		match "disablechatter", use_prefix: true, method: :disableChanChat
		match "enablechatter", use_prefix: true, method: :enableChanChat
		match(/^\/me!disablechatter (.+)/, use_prefix: false, method: :disableChanChat)
		match(/^\/me!enablechatter (.+)/, use_prefix: false, method: :enableChanChat)

		def initialize(*args)
			super
			@enabled = true
			@defaultnick = config[:defaultnick] || "cleverBot"
			regexp = /[A-Z]/
			matched = regexp.match(@defaultnick)
			if matched
				matched = matched[0]
			else
				matched = "?"
			end
			@prefixUse = true
			@disabledChannels = Set.new
			@cleverbot = Cleverbot::Client.new
		end

		def execute(m, message)
			return unless @enabled
			return if /flip (.+)/ =~ message || /help (.+)/ =~ message
			return if [ "whatson", "whatsnext", "schedule", "help", "flip",
									"tumbleweed", "disablechatter", "enablechatter",
									"globaldisable", "globalenable", "chatterhelp" ].include? message
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
