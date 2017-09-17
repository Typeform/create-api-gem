class RetrieveMessagesRequest < APIRequest
  def initialize(user, form)
    request(
      method: :get,
      url: "#{PannacottaConfig.api_request_url}/forms/#{form.id}/messages",
      headers: {
        'Typeform-Request-Id' => DataGenerator.uuid,
        'Authorization' => "Bearer #{user.jwt}"
      }
    )
  end

  def success?
    @response.code == 200 && json?
  end

  def messages
    Messages.from_response(json)
  end
end
