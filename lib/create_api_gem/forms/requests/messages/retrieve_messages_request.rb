class RetrieveMessagesRequest < MessagesRequest
  def initialize(form, token: APIConfig.token)
    request(
      method: :get,
      url: "#{APIConfig.api_request_url}/forms/#{form.id}/messages",
      headers: {
        'Typeform-Request-Id' => DataGenerator.uuid,
        'Authorization' => "Bearer #{token}"
      }
    )
  end

  def success?
    @response.code == 200 && json?
  end
end
