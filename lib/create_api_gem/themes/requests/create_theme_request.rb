require_relative 'theme_request'

class CreateThemeRequest < ThemeRequest
  def initialize(token, theme)
    request(
      method: :post,
      url: "#{APIConfig.api_request_url}/themes",
      headers: {
        'Authorization' => "Bearer #{token}"
      },
      payload: theme.payload
    )
  end

  def success?
    @response.code == 201 && json?
  end
end
