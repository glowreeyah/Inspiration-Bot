require_relative './database_manager'

class SaveMessage
  include DatabaseManager

  def initialize(message_object)
    @user = message_object.chat.id
    @date = Time.at(message_object.date).strftime('%e %b %Y %k:%M')
    @message = message_object.text.to_s
  end

  def save_message
    date_and_message = "#{@date}: #{@message}"
    append_to_file(@user, date_and_message)
  end

  def delete_message(index)
    return if index.zero?

    entry_to_delete = file_to_arr(@user)[index - 1]
    remove_from_file(@user, entry_to_delete)
  end

  def messages
    return unless file_exists?(@user)

    get_string = "\n"
    file_to_arr(@user).each_with_index do |entry, i|
      get_string += "\n#{i + 1}. #{entry}\n"
    end
    get_string
  end
end

# SaveMessage.new(1061110010, 'hi there!').save_message
