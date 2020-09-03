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
