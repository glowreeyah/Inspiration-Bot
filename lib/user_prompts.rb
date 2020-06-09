require_relative '../lib/save_message.rb'
require_relative '../lib/state_manager.rb'

class UserPrompts
  private

  attr_reader :message_object
  attr_reader :chat_id

  def initialize(message_object)
    @message_object = message_object
    @chat_id = message_object.chat.id
  end

  def clear_states
    StateManager.new(message_object, 'writers').false_state
    StateManager.new(message_object, 'deleters').false_state
  end

  def user_online
    StateManager.new(message_object, 'users').true_state
  end

  def user_offline
    StateManager.new(message_object, 'users').false_state
  end

  def write_state
    StateManager.new(message_object, 'writers').true_state
  end

  def delete_state
    StateManager.new(message_object, 'deleters').true_state
  end

  def in_write?
    StateManager.new(message_object, 'writers').state?
  end

  def in_delete?
    StateManager.new(message_object, 'deleters').state?
  end

  public

  def start
    clear_states
    user_online

    "Hello #{message_object.from.first_name} 😁
\nI am your GLA Buddy and will like to send you nuggests from pastor's messages everyday.
You can get one immediately by typing /word
\nIf you would like me to pause/re-start the Word reminder, you can reply with /stop and /start.
\nYou can also write or view your testimony by typing /write and /view"
  end

  def help
    clear_states
    "Here is a list of available commands:\n/start\n/stop\n/write\n/delete\n/view\n/word"
  end

  def stop
    clear_states
    user_offline
    'You have paused your daily nugget notifications.'
  end

  def write
    clear_states
    write_state
    "What are your testimonies?
I will love to randomly remind you to document your testimony \
in the future to remind you of the workings of your faith 🥳.
\nTo cancel this entry type /cancel"
  end

  def cancel
    clear_states
    'Your testimony entry has been cancelled.'
  end

  def view
    clear_states
    "Here are your testimony entries: #{SaveMessage.new(message_object).messages}"
  end

  def delete
    clear_states
    delete_state
    "Reply with the testimony entry number to delete: #{SaveMessage.new(message_object).messages}"
  end

  def testimony_entry
    if in_write?
      clear_states
      SaveMessage.new(message_object).save_message
      "Amazing! I have saved your testimony entry.
\nIf you would like to take a look at your entries you can send me /view"

    elsif in_delete?
      clear_states
      SaveMessage.new(message_object).delete_message(message_object.text.to_i)
      "Entry deleted! #{view}"
    end
  end

  def word
    clear_states
    file_data = File.read('./db/nuggets.txt').split("\n")
    file_data[rand(1..file_data.size)].to_s
  end
end
