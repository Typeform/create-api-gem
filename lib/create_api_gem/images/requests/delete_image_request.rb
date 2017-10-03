require_relative 'image_request'

class DeleteImageRequest < ImageRequest
  def initialize(token = APIConfig.token, image)
    request(
      method: :delete,
      url: "#{APIConfig.api_request_url}/images/#{image.id}",
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{token}"
      }
    )
  end

  def success?
    @response.code == 204
  end
end
