require_relative 'theme_request'

class UpdateThemeRequest < ThemeRequest
  def initialize(token = APIConfig.token, theme)
    request(
      method: :put,
      url: "#{APIConfig.api_request_url}/themes/#{theme.id}",
      headers: {
        'Authorization' => "Bearer #{token}"
      },
      payload: theme.payload
    )
  end

  def success?
    @response.code == 200 && json?
  end
end
