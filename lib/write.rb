class MessageResponse
  def initialize(message)
    @message = message
    @chat_id = message.chat.id
  end

  def self.default_reply
    "Oops, I didn't understand that. Please try sending me one of the commands from /help"
  end

  def start
    
    "Hello #{message.from.first_name} :smiley: \nI will like to send you nuggests from pastor's messages everyday."
  end
end