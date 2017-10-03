require_relative 'theme_request'

class RetrieveThemeRequest < ThemeRequest
  def initialize(theme, token = APIConfig.token)
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
