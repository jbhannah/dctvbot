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
			@abbreviation = @defaultnick[0].chr.capitalize
			@abbreviation << matched
			@abbreviation << ": "
			@prefixUse = true
			@cleverbot = Cleverbot::Client.new
			colour1 = rand(200).to_s
			colour1 << ','
			colour2 = rand(200).to_s
			colour2 << ','
			colour3 = rand(200).to_s
			combinedcolour = colour1
			combinedcolour << colour2
			combinedcolour << colour3
			@defaultPrefix = "<c="
			@defaultPrefix << combinedcolour
			@defaultPrefix << ">"
			@defaultPrefix << @abbreviation
			@defaultSuffix = "<\/c>"
		end

		def execute(m, message)
			return unless @enabled
			return if /flip (.+)/ =~ message || /help (.+)/ =~ message
			return if [ "whatson", "whatsnext", "schedule", "help", "flip",
									"tumbleweed", "disablechatter", "enablechatter",
									"globaldisable", "globalenable", "chatterhelp" ].include? message
			if m.channel
				msg_back = @cleverbot.write message
				m.reply(msg_back, @prefixUse)
			end
		end

		def disableChanChat(m, message)
			return unless authenticated? m
			prefix = @defaultPrefix.dup
			suffix = @defaultSuffix.dup
			tosend = prefix
			tosend << "CleverBot disabled."
			tosend << suffix
			m.reply(tosend, false)
		end

		def enableChanChat(m, message)
			return unless authenticated? m
			prefix = @defaultPrefix.dup
			suffix = @defaultSuffix.dup
			tosend = prefix
			tosend << "CleverBot enabled."
			tosend << suffix
			m.reply(tosend, false)
		end
	end

end
