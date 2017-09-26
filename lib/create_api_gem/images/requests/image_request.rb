require_relative '../../api_request'

class ImageRequest < APIRequest
  def image
    Image.from_response(json)
  end
end