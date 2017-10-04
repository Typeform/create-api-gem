class MessagesRequest < APIRequest
  def messages
    Messages.from_response(json)
  end
end
