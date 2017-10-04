require_relative 'form_request'

class CreateFormRequest < FormRequest
  def initialize(form, token: APIConfig.token)
    request(
      method: :post,
      url: "#{APIConfig.api_request_url}/forms",
      headers: {
        'Authorization' => "Bearer #{token}"
      },
      payload: form.payload
    )
  end

  def success?
    @response.code == 201 && json?
  end
end
