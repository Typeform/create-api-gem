class Messages
  attr_accessor :messages

  def initialize(messages)
    @messages = Hash[messages.map { |(k, v)| [k.to_sym, v] }]
  end

  def self.from_response(response)
    Messages.new(response)
  end

  def payload
    messages
  end

  def same?(actual)
    messages == actual.messages
  end
end
