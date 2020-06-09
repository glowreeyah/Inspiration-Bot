#!/usr/bin/env ruby
require 'telegram/bot'
require 'dotenv/load'
require_relative '../lib/user_prompts.rb'

token = ENV['API_KEY']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message_object|
    chat_id = message_object.chat.id
    response = case message_object.text
               when %r{^/start}
                 UserPrompts.new(message_object).start
               when %r{^/help}
                 UserPrompts.new(message_object).help
               when %r{^/stop}
                 UserPrompts.new(message_object).stop
               when %r{^/write}
                 UserPrompts.new(message_object).write
               when %r{^/cancel}
                 UserPrompts.new(message_object).cancel
               when %r{^/view}
                 UserPrompts.new(message_object).view
               when %r{^/word}
                 UserPrompts.new(message_object).word
               when %r{^/delete}
                 UserPrompts.new(message_object).delete
               else
                 UserPrompts.new(message_object).testimony_entry
               end
    response ||= "OOPS! I didn't get that! Please try a using a command from /help"
    bot.api.send_message(chat_id: chat_id, text: response)
    puts message_object.from.first_name
  end
end
