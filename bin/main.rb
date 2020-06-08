#!/usr/bin/env ruby
require 'telegram/bot'
require 'dotenv/load'
load './lib/write.rb'
load './lib/entries.rb'
file_data = File.read('./db/nuggets.txt').split("\n")

token = ENV['TELEGRAM_API_KEY']


Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    chat_id = message.chat.id
    case message.text
    when %r{^/start}
      message_sent = bot.api.send_message(chat_id: chat_id, text: "Hello #{message.from.first_name} 😁 \nI will like to send you nuggests from pastor's messages everyday.\nIf you would like me to pause/re-start the reminders, you can reply with /stop and /start")
      # bot.api.send_message(chat_id: chat_id, text: "Quote of the day:\n#{file_data[rand(1...file_data.size)]}")
      Entries.new(chat_id)
      puts message.from.first_name

    when %r{^/stop} 
      bot.api.send_message(chat_id: chat_id, text: "You have paused your nugget notifications.")

      Entries.new(chat_id).remove_user(chat_id)

    when %r{^/write}
      bot.api.send_message(chat_id: chat_id, text: "What are your testimonies?\n")

      Write.new(chat_id)

    when %r{^/delete}
      Write.new(chat_id).remove_user(chat_id)

      bot.api.send_message(chat_id: chat_id, text: "Your testimony entry has been deleted.")
    
    when %r{^/view}
      bot.api.send_message(chat_id: chat_id, text: "Here are your testimony entries #{SaveMessage.get_messages(chat_id)}")
      SaveMessage.get_messages(chat_id)

    else
      if Write.write_state?(chat_id)
        Write.new(chat_id).remove_user(chat_id)
        SaveMessage.new(chat_id, message.text).store_message
        bot.api.send_message(chat_id: chat_id, text: "Glory, Hallelujah! I have saved your testimony entry, if you would like to take a look at your entries you can send me /view")
      end
    end
  end
end  