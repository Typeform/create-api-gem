require_relative 'theme_request'

class RetrieveAllThemesRequest < APIRequest
  def initialize(token, page: nil, page_size: nil, visibility: nil)
    parameters = {}
    parameters[:page] = page unless page.nil?
    parameters[:page_size] = page_size unless page_size.nil?
    parameters[:visibility] = visibility unless visibility.nil?
    request(
      method: :get,
      url: "#{PannacottaConfig.api_request_url}/themes?" + parameters.to_query,
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
