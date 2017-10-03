require_relative 'theme_request'

class RetrieveThemeRequest < ThemeRequest
  def initialize(token = APIConfig.token, theme)
    headers = {}
    headers = { 'Authorization' => "Bearer #{token}" } unless token.nil?
    request(
      method: :get,
      url: "#{APIConfig.api_request_url}/themes/#{theme.id}",
      headers: headers
    )
  end

  def success?
    @response.code == 200 && json?
  end
end
