require_relative './database_manager'

# include DatabaseManager

class StateManager
  include DatabaseManager
  extend DatabaseManager

  def initialize(message_object, state_managed)
    @chat_id = message_object.chat.id
    @state_managed = state_managed
  end

  def true_state
    return if state?

    append_to_file(@state_managed, @chat_id)
  end

  def state?
    contain_in_file?(@state_managed, @chat_id)
  end

  def false_state
    remove_from_file(@state_managed, @chat_id)
  end

  def self.items_managed(state_managed)
    file_to_arr(state_managed)
  end
end

# Tests
# puts StateManager.items_managed('users')
