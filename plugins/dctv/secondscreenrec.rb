# encoding: utf-8

module Plugins
  module DCTV

    class SecondScreenRec
      include Cinch::Plugin
      include Cinch::Extensions::Authentication

      enable_authentication

      match /secsrec on/, method: :on
      def on(m)
        @bot.record_second_screen = true
        @bot.recorded_second_screen_list.clear

        m.user.notice "Second Screen Recording enabled"
      end

      match /secsrec off/, method: :off
      def off(m)
        @bot.record_second_screen = false
        @bot.recorded_second_screen_list.clear

        m.user.notice "Second Screen Recording disabled"
      end

      match /secsrec publish/, method: :publish
      def publish(m)
        list = @bot.recorded_second_screen_list

        return if (list.empty?)

        url = URI.parse("http://pastebin.com/api/api_post.php")

        str = ""
        list.each do |link|
          str += "#{link}\n"
        end

        params = {
          "api_dev_key" => config[:pastebin_api_key],
          "api_option" => "paste", # Specifies creation
          "api_paste_code" => str
        }

        res = Net::HTTP.post_form(url, params)

        m.reply res.body
      end
    end

  end
end
