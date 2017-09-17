require_relative 'form_request'

class RetrieveHeadFormRequest < FormRequest
  def initialize(token, form)
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
