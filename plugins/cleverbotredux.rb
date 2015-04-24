# encoding: utf-8
# Adapted from https://github.com/curiouslyExistential/cinch-cleverbotredux

module Plugins

	class CleverBotRedux
		include Cinch::Plugin
		include Cinch::Extensions::Authentication

		match lambda { |m| /^#{m.bot.nick}[:,]?\s*(.+)/i }, use_prefix: false

		def initialize(*args)
			super
			@cleverbot = Cleverbot::Client.new
		end

		def execute(msg, query)
			return unless (@bot.cleverbot_enabled || authenticated?(msg))
			if msg.channel
				response = @cleverbot.write query
				msg.reply response, true
			end
		end
	end

end
