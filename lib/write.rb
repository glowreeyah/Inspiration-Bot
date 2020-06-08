require_relative 'entries.rb'

class Write < Entries
  @@file = '../db/users_test.txt'

  def initialize(user)
    @user = user
    @file = '../db/users.txt'
    @@users = update_arr(@user, @file)
  end

  def self.in_write_state?(user)
    current_users = File.read('../db/users_test.txt').split("\n")
    puts current_users
    return true if current_users.include? user.to_s
  end
end

# puts Write.in_write_state?(1061110010)
# puts Write.new(1061110010)