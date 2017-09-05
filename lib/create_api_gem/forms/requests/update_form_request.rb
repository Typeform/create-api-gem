require_relative 'form_request'

class UpdateFormRequest < FormRequest
  def initialize(token, form)
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
