#!/usr/bin/env ruby
require 'telegram/bot'
require 'dotenv/load'
require_relative '../lib/save_message.rb'
require_relative '../lib/state_manager.rb'
file_data = File.read('./db/nuggets.txt').split("\n")

token = ENV['TELEGRAM_API_KEY']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    chat_id = message.chat.id
    case message.text
    when %r{^/start}
      bot.api.send_message(chat_id: chat_id, text: "Hello #{message.from.first_name} 😁 \nI am your GLA Buddy and will like to send you nuggests from pastor's messages everyday. You can get one immediately by typing /word\nIf you would like me to pause/re-start the Word reminder, you can reply with /stop and /start.\nYou can also write or view your testimony by typing /write and /view")
      
      StateManager.new(message, 'users').true_state
      StateManager.new(message, 'writers').false_state

      puts message.from.first_name

    when %r{^/stop}
      bot.api.send_message(chat_id: chat_id, text: 'You have paused your daily nugget notifications.')

      StateManager.new(message, 'users').true_state
      StateManager.new(message, 'writers').false_state

    when %r{^/write}
      bot.api.send_message(chat_id: chat_id, text: "What is/are your testimonies?\n(I will love to randomly remind you to document your testimony in the future to remind you of the workings of your faith 🥳)\nTo cancel this entry type /cancel")

      StateManager.new(message, 'writers').true_state

    when %r{^/cancel}
      StateManager.new(message, 'writers').false_state

      bot.api.send_message(chat_id: chat_id, text: 'Your testimony entry has been cancelled.')
      StateManager.new(message, 'writers').false_state

    when %r{^/view}
      bot.api.send_message(chat_id: chat_id, text: "Here are your testimony entries: #{SaveMessage.new(message).messages}")
      StateManager.new(message, 'writers').false_state

    when %r{^/word}
      bot.api.send_message(chat_id: chat_id, text: (file_data[rand(1..file_data.size)]).to_s)
      StateManager.new(message, 'writers').false_state

    else
      if StateManager.new(message, 'writers').state?
        StateManager.new(message, 'writers').false_state
        SaveMessage.new(message).save_message
        bot.api.send_message(chat_id: chat_id, text: 'Amazing! I have saved your testimony entry, if you would like to take a look at your entries you can send me /view')
      end
    end
  end
end
