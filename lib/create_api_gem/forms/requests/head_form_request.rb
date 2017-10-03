require_relative 'form_request'

class HeadFormRequest < FormRequest
  def initialize(form, token = APIConfig.token)
    r = {
      method: :head,
      url: "#{APIConfig.api_request_url}/forms/#{form.id}"
    }
    r[:headers] = { 'Authorization' => "Bearer #{token}" } unless token.nil?

    request(r)
  end

  def success?
    @response.code == 200
  end
end
