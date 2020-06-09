#!/usr/bin/env ruby

require 'telegram/bot'
require 'dotenv/load'
require_relative '../lib/state_manager.rb'

token = ENV['TELEGRAM_API_KEY']

file_data = File.read('../db/nuggets.txt').split("\n")

loop do
  users = StateManager.items_managed('users')
  users.each do |user|
    Telegram::Bot::Client.run(token) do |bot|
      bot.api.send_message(chat_id: user, text: "Word for the day:\n#{file_data[rand(1...file_data.size)]}")
    end
    p user
    sleep(1)
  end

  puts Time.now
  sleep(14_400)
end
