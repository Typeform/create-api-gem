class UpdateMessagesRequest < APIRequest
  def initialize(user, form, messages)
    request(
      method: :put,
      url: "#{PannacottaConfig.api_request_url}/forms/#{form.id}/messages",
      headers: {
        'Typeform-Request-Id' => Fake.uuid,
        'Authorization' => "Bearer #{user.jwt}"
      },
      payload: messages.payload.to_json
    )
  end

  def success?
    @response.code == 204
  end

  def payment_required?
    @response.code == 402
  end
end
