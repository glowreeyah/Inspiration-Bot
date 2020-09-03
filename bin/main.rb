#!/usr/bin/env ruby
require 'telegram/bot'
require 'dotenv/load'
require_relative '../lib/user_prompts.rb'
require_relative '../lib/state_manager.rb'
file_data = File.read('./db/nuggets.txt').split("\n")

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
    response ||= "OOPS! I didn't get that! Please try using a command from /help"
    bot.api.send_message(chat_id: chat_id, text: response)
  end
end


def send_message(message, user)
  key = ENV['API_KEY']
  Telegram::Bot::Client.run(key) do |bot|
    bot.api.send_message(chat_id: user, text: message)
  end
end

def user_list
  StateManager.items_managed('users')
end

loop do # rubocop:todo Metrics/BlockLength
  users = user_list

  users.each do |user|
    begin
      send_message("Word for the day:\n#{file_data[rand(0..file_data.size)]}", user)
    rescue StandardError
      p 'Unable'
    end
    sleep(1)
  end
  sleep(300)

  users = user_list

  users.each do |user|
    begin
      send_message("What are your testimonies?😊\nSend /write to make an entry", user)
    rescue StandardError
      p 'Unable'
    end
    sleep(1)
  end
  sleep(300)

  users = user_list
  users.each do |user|
    next unless File.file?("./db/#{user}.txt")

    user_entry = File.read("./db/#{user}.txt").split("\n")
    begin
      send_message("One of your testimonies 🥳:\n #{user_entry[rand(0..user_entry.size)]}", user)
    rescue StandardError
      p 'Unable'
    end
    sleep(1)
  end
  sleep(300)
end
