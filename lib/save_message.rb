require_relative './database_manager'

class SaveMessage
  include DatabaseManager

  def initialize(message_object)
    @user = message_object.chat.id
    @date = Time.at(message_object.date).strftime('%e %b %Y %k:%M')
    @message = message_object.text.to_s
  end

  def save_message
    n = File.new("./db/#{@user}", 'a')
    n.write("#{@date}: #{@message}\n")
    n.close
  end

  def self.get_messages(user)
    get_string = "\n"
    entries = File.read(".db/#{user}".split("\n")) if File.file?("./db/#{user}")
    entries.each do |entry|
      get_string += "\n#{entry}\n"
    end
  get_string
  end
end
  # SaveMessage.new(1061110010, 'hi there!').save_message

  # p SaveMessage.get_messages(1061110010)