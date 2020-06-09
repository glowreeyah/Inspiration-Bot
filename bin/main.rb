#!/usr/bin/env ruby
require 'telegram/bot'
require 'dotenv/load'
require_relative '../lib/save_message.rb'
require_relative '../lib/state_manager.rb'
require_relative '../lib/user_prompts.rb'

token = ENV['TELEGRAM_API_KEY']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message_object|
    chat_id = message_object.chat.id
    case message_object.text
    when %r{^/start}
      user_response = UserPrompts.new(message_object).start
    when %r{^/stop}
      user_response = UserPrompts.new(message_object).stop
    when %r{^/help}
      user_response = UserPrompts.new(message_object).help
    when %r{^/write}
      user_response = UserPrompts.new(message_object).write
    when %r{^/cancel}
      user_response = UserPrompts.new(message_object).cancel
    when %r{^/view}
      user_response = UserPrompts.new(message_object).view
    when %r{^/word}
      user_response = UserPrompts.new(message_object).word
    when %r{^/delete}
      user_response = UserPrompts.new(message_object).delete

    else
      user_response = 'Entry deleted!' if StateManager.new(message_object, 'writers').state?
    end
    bot.api.send_message(chat_id: chat_id, text: user_response)
    # puts message_object.from.first_name
  end
end
