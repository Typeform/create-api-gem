require_relative 'form_request'

class RetrieveAllFormsRequest < FormRequest
  def initialize(user, forms_per_page: 10)
    r = {
      method: :get,
      url: "#{PannacottaConfig.api_request_url}/forms?page_size=#{forms_per_page}"
    }
    r[:headers] = { 'Authorization' => "Bearer #{user.jwt}" } unless user.nil?

    request(r)
  end

  def success?
    @response.code == 200 && json?
  end

  def forms
    json.fetch(:items)
  end
end
