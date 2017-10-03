require_relative 'form_request'

class DeleteFormRequest < FormRequest
  def initialize(token = APIConfig.token, form)
    request(
      method: :delete,
      url: "#{APIConfig.api_request_url}/forms/#{form.id}",
      headers: {
        'Authorization' => "Bearer #{token}"
      }
    )
  end

  def success?
    @response.code == 204
  end
end
