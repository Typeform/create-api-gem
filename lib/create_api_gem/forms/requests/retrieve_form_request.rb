require_relative 'form_request'

class RetrieveFormRequest < FormRequest
  def initialize(token, form)
    request(
      method: :get,
      url: "#{APIConfig.api_request_url}/forms/#{form.id}",
      headers: {
        'Authorization' => "Bearer #{token}"
      }
    )
  end

  def success?
    @response.code == 200 && json?
  end
end
