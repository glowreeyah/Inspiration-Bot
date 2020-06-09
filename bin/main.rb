#!/usr/bin/env ruby
require 'telegram/bot'
require 'dotenv/load'
require_relative '../lib/save_message.rb'
require_relative '../lib/state_manager.rb'
file_data = File.read('./db/nuggets.txt').split("\n")

token = ENV['TELEGRAM_API_KEY']

Telegram::Bot::Client.run(token) do |bot| # rubocop:todo Metrics/BlockLength
  bot.listen do |message_object| # rubocop:todo Metrics/BlockLength
    chat_id = message_object.chat.id
    case message_object.text
    when %r{^/start}
      bot.api.send_message(chat_id: chat_id, text: "Hello #{message_object.from.first_name} 😁
      \nI am your GLA Buddy and will like to send you nuggests from pastor's messages everyday.
      You can get one immediately by typing /word
      \nIf you would like me to pause/re-start the Word reminder, you can reply with /stop and /start.
      \nYou can also write or view your testimony by typing /write and /view")

      StateManager.new(message_object, 'users').true_state
      StateManager.new(message_object, 'writers').false_state
      StateManager.new(message_object, 'deleters').false_state

    when %r{^/stop}
      bot.api.send_message(chat_id: chat_id, text: 'You have paused your daily nugget notifications.')

      StateManager.new(message_object, 'users').true_state
      StateManager.new(message_object, 'writers').false_state
      StateManager.new(message_object, 'deleters').false_state

    when %r{^/write}
      bot.api.send_message(chat_id: chat_id, text: "What is/are your testimonies?
      I will love to randomly remind you to document your testimony \
      in the future to remind you of the workings of your faith 🥳)
      \nTo cancel this entry type /cancel")

      StateManager.new(message_object, 'writers').true_state
      StateManager.new(message_object, 'deleters').false_state

    when %r{^/cancel}
      StateManager.new(message_object, 'writers').false_state

      bot.api.send_message(chat_id: chat_id, text: 'Your testimony entry has been cancelled.')
      StateManager.new(message_object, 'writers').false_state

    when %r{^/view}
      bot.api.send_message(chat_id: chat_id, text: "Here are your testimony entries:
      #{SaveMessage.new(message_object).messages}")
      StateManager.new(message_object, 'writers')
      StateManager.new(message_object, 'deleters').false_state

    when %r{^/word}
      bot.api.send_message(chat_id: chat_id, text: (file_data[rand(1..file_data.size)]).to_s)
      StateManager.new(message_object, 'writers').false_state
      StateManager.new(message_object, 'deleters').false_state

    when %r{^/delete}
      StateManager.new(message_object, 'deleters').true_state
      bot.api.send_message(chat_id: chat_id, text: "Reply with the testimony entry number to delete:
      #{SaveMessage.new(message_object).messages}")

    else
      if StateManager.new(message_object, 'writers').state?
        StateManager.new(message_object, 'writers').false_state
        SaveMessage.new(message_object).save_message
        bot.api.send_message(chat_id: chat_id, text: "Amazing! I have saved your testimony entry.
        \nIf you would like to take a look at your entries you can send me /view")
      elsif StateManager.new(message_object, 'deleters').state?
        StateManager.new(message_object, 'deleters').false_state
        StoreMessage.new(message_object).delete_message(message.text.to_i)
        bot.api.send_message(chat_id: chat_id, text: 'Entry deleted!')
      end
    end
    # puts message_object.from.first_name
  end
end
