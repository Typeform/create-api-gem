require_relative 'theme_request'
require 'rack'

class RetrieveAllThemesRequest < APIRequest
  def initialize(token: APIConfig.token, page: nil, page_size: nil, visibility: nil)
    parameters = Rack::Utils.build_query(
      page: page,
      page_size: page_size,
      visibility: visibility
    )
    request(
      method: :get,
      url: "#{APIConfig.api_request_url}/themes?" + parameters,
      headers: {
        'Authorization' => "Bearer #{token}"
      },
      verify_ssl: OpenSSL::SSL::VERIFY_NONE
    )
  end

  def bad_request?
    @response.code == 400 && json?
  end

  def success?
    @response.code == 200 && json?
  end

  def themes
    json.fetch(:items)
  end

  def total_items
    json.fetch(:total_items)
  end

  def page_count
    json.fetch(:page_count)
  end
end
