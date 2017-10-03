require_relative 'image_request'

class RetrieveAllImagesRequest < ImageRequest
  def initialize(token = APIConfig.token)
    request(
      method: :get,
      url: "#{APIConfig.api_request_url}/images",
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{token}"
      }
    )
  end

  def success?
    @response.code == 200
  end
end
