require_relative 'form_request'

class RetrieveAllFormsRequest < FormRequest
  def initialize(token, forms_per_page: 10)
    r = {
      method: :get,
      url: "#{PannacottaConfig.api_request_url}/forms?page_size=#{forms_per_page}"
    }
    r[:headers] = { 'Authorization' => "Bearer #{token}" } unless token.nil?

    request(r)
  end

  def success?
    @response.code == 200 && json?
  end

  def forms
    json.fetch(:items)
  end
end
