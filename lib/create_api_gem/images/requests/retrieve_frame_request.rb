require_relative 'image_request'

class RetrieveFrameRequest < ImageRequest
  def initialize(image, frame)
    request(
      method: :get,
      url: "#{APIConfig.image_api_request_url}/images/#{image.id}-#{frame}frame.png",
      headers: {
        'Content-Type' => 'application/json'
      }
    )
  end

  def success?
    @response.code == 200
  end
end