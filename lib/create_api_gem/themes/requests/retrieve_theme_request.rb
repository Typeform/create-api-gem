require_relative 'theme_request'

class RetrieveThemeRequest < ThemeRequest
  def initialize(token, theme)
    request(
      method: :get,
      url: "#{APIConfig.api_request_url}/themes/#{theme.id}",
      headers: {
        'Authorization' => "Bearer #{token}"
      }
    )
  end

  def success?
    @response.code == 200 && json?
  end
end
