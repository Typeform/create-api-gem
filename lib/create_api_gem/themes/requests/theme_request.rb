require_relative 'theme_request'

class ThemeRequest < APIRequest
  def location_header
    headers.fetch(:location)
  end

  def theme
    Theme.from_response(json)
  end

  def invalid_theme?
    @response.code == 400
  end

  def not_found_theme?
    @response.code == 404
  end

  def forbidden?
    @response.code == 403
  end

  def theme_id
    headers.fetch(:location).split('/themes/')[1]
  end
end
