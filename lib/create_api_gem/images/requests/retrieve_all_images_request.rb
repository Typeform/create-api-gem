require_relative 'image_request'

class RetrieveAllImagesRequest < ImageRequest
  def initialize(token)
    request(
      method: :get,
      url: "#{APIConfig.image_api_request_url}/images",
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