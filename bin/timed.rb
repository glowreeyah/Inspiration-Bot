#!/usr/bin/env ruby

require 'telegram/bot'
require 'dotenv/load'
require_relative '../lib/state_manager.rb'

file_data = File.read('./db/nuggets.txt').split("\n")

def send_message(message, user)
  key = ENV['API_KEY']
  Telegram::Bot::Client.run(key) do |bot|
    bot.api.send_message(chat_id: user, text: message)
  end
end

loop do
  users = StateManager.items_managed('users')
  users.each do |user|
    send_message("Word for the day:\n#{file_data[rand(0..file_data.size)]}", user)
    p user
    sleep(1)
  end
  puts 'word sent'
  puts Time.now
  sleep(43_200)

  users.each do |user|
    send_message("What are your testimonies?😊\nSend /write to make an entry", user)
    p user
    sleep(1)
  end
  puts 'write testimony'
  puts Time.now
  sleep(43_200)

  users.each do |user|
    send_message("One of your testimonies 🥳:\n #{user_entry[rand(0..user_entry.size)]}", user)
    p user
    sleep(1)
  end

  puts 'Testimony entry reminder'
  puts Time.now
  sleep(43_200)
end
