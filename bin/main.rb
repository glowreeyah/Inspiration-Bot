#!/usr/bin/env ruby
require 'telegram/bot'
require 'dotenv/load'
load './lib/write.rb'
load './lib/entries.rb'
file_data = File.read('./db/nuggets.txt').split("\n")

token = ENV['TELEGRAM_API_KEY']


Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    message_id = message.chat.id
    case message.text
    when %r{^/start}
      message_sent = bot.api.send_message(chat_id: message_id, text: "Hello #{message.from.first_name} 😁 \nI will like to send you nuggests from pastor's messages everyday.\nIf you would like me to pause/re-start the reminders, you can reply with /stop and /start")
      # bot.api.send_message(chat_id: message_id, text: "Quote of the day:\n#{file_data[rand(1...file_data.size)]}")
      # puts message_sent.text
      Entries.new(message_id)
      # puts message.from.first_name

    when %r{^/stop} 
      bot.api.send_message(chat_id: message_id, text: "You have paused your nugget notifications.")

      Entries.new(message_id).remove_user(message_id)

    when %r{^/write}
      bot.api.send_message(chat_id: message_id, text: "What are your testimonies?\n")

      Write.new(message_id)
    
    when %r{^/delete}
      Write.new(message_id).remove_user(message_id)

      bot.api.send_message(chat_id: message_id, text: "Your testimony entry has been deleted.")

    else
      puts Write.write_state?(message_id)
    end
  end
end  