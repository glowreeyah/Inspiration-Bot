# frozen_string_literal: true

class Entries
  attr_reader :user, :file
  @@users = []
  @@file = '.db/users.txt'

  def initialize(user)
    @user = user
    @file = '.db/users.txt'
    @@users = update_arr(@user, @file)
  end

  def self.users
    @@users = File.read(@@file).split("\n")
  end

  def delete_user(use)
    uses = File.read(@file).split("\n")
    uses.delete(use.to_s)
    n = File.new(@file, 'w')
    uses.each do |item|
      n.write("#{item}\n")
    end
    n.close
  end

  private

  def update_arr(user, file)
    current_users = File.read(file).split("\n")
    unless current_users.include? user.to_s
      n = File.new(file, 'a')
      n.write("#{user}\n")
      n.close
    end
    current_users
  end

  # def save_entry(user, data)
  #   entry_data[user.to_sym][Time.new.strftime('%Y%m%d%H%M%S').to_s.to_sym.to_sym] = data
  # end
end

puts Entries.users