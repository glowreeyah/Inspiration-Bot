require_relative './database_manager'

class SaveMessage
  include DatabaseManager

  def initialize(message_object)
    @user = message_object.chat.id
    @date = Time.at(message_object.date).strftime('%e %b %Y %k:%M')
    @message = message_object.text.to_s
  end

  def save_message
    date_and_message = "#{@date}: #{@message}\n"
    append_to_file(@user, date_and_message)
  end

  def messages(user)
    return unless file_exists?(@user)

    get_string = "\n"
    file_to_arr(@user).each do |entry|
      get_string += "\n#{entry}\n"
    end
    get_string
  end
end
# SaveMessage.new(1061110010, 'hi there!').save_message

# p SaveMessage.get_messages(1061110010)
