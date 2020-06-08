class SaveMessage
  def initialize(user,message)
    @user = user
    @message = message
  end

  def save_message
    n = File.new("./db/#{@user}", 'a')
    n.write("#{@message}\n")
    n.close
  end

  def self.get_messages(user)
    File.read(".db/#{user}".split("\n"))
  end
end

 StoreMessage.new(1061110010, 'hi there!').store_message


 p StoreMessage.get_messages(1061110010)