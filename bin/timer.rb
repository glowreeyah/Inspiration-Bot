#!/usr/bin/env ruby
# frozen_string_literal: true

require 'telegram/bot'
require_relative '../lib/entries.rb'

file_data = File.read('./db/nuggets.txt').split("\n")

token = ENV['TELEGRAM_API_KEY']

loop do
  users = Entries.users
  users = [+234 7034653696]
  i = 0
  while i < users.size
    user = users[i].to_i

    Telegram::Bot::Client.run(token) do |bot|
      bot.api.send_message(chat_id: user, text: "Word of the day:\n#{file_data[rand(1...file_data.size)]}")
    end
    p user
    i += 1
  end
  sleep(14_400)
end