class CreateImageRequest < APIRequest
  def initialize(token, image)
    request(
      method: :post,
      url: "#{APIConfig.api_request_url}/images",
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{token}"
      },
      payload: image.payload
    )
  end

  def id
    json.fetch(:id)
  end

  def src
    json.fetch(:src)
  end

  def success?
    @response.code == 201 && json?
  end

  def error?
    @response.code != (201 || 200)
  end
end