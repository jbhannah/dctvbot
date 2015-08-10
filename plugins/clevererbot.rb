# encoding: utf-8

module Plugins

	class ClevererBot
		include Cinch::Plugin
		include Cinch::Extensions::Authentication

		match lambda { |m| /^@?#{m.bot.nick}[:,]?\s*(.+)/i }, use_prefix: false

		def initialize(*args)
			super
			@cleverbot = Cleverbot::Client.new
		end

		def execute(m, query)
			return unless (@bot.cleverbot_enabled || authenticated?(m))
			response = @cleverbot.write query
			m.reply response, true
		end
	end

end
