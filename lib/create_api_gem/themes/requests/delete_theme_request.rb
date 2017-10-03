require_relative 'theme_request'

class DeleteThemeRequest < ThemeRequest
  def initialize(token = APIConfig.token, theme)
    request(
      method: :delete,
      url: "#{APIConfig.api_request_url}/themes/#{theme.id}",
      headers: {
        'Authorization' => "Bearer #{token}"
      }
    )
  end

  def success?
    @response.code == 204
  end
end
