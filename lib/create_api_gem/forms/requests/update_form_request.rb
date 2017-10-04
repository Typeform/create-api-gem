require_relative 'form_request'

class UpdateFormRequest < FormRequest
  def initialize(form, token: APIConfig.token)
    request(
      method: :put,
      url: "#{APIConfig.api_request_url}/forms/#{form.id}",
      headers: {
        'Authorization' => "Bearer #{token}"
      },
      payload: form.payload
    )
  end

  def success?
    @response.code == 200 && json?
  end
end
