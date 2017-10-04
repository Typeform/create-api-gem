require_relative 'image_request'

class CreateImageRequest < ImageRequest
  def initialize(image, token: APIConfig.token)
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

  def success?
    @response.code == 201 && json?
  end
end
