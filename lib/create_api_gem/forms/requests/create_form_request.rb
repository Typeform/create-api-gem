require_relative 'form_request'

class CreateFormRequest < FormRequest
  def initialize(token = APIConfig.token, form)
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
