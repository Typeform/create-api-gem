require_relative 'image_request'

class RetrieveImageRequest < ImageRequest
  def initialize(image, type: nil, size: nil, accept: nil)
    url = if type.nil? && size.nil?
            "#{APIConfig.image_api_request_url}/images/#{image.id}"
          else
            "#{APIConfig.image_api_request_url}/images/#{image.id}/#{type}/#{size}"
          end
    if accept == 'video'
      url << '?format=mp4'
    end
    headers = { 'Content-Type' => 'application/json' }
    headers['Accept'] = 'application/json' if accept == 'json'
    request(
      method: :get,
      url: url,
      headers: headers
    )
  end

  def success?
    @response.code == 200
  end

  def error?
    @response.code != 200
  end
end
