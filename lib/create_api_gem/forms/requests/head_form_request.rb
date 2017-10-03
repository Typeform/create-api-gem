require_relative 'form_request'

<<<<<<< 078054fd6ccb8f6f14b2814721829ba9270b5e2a:lib/create_api_gem/forms/requests/head_form_request.rb
class HeadFormRequest < FormRequest
  def initialize(token = APIConfig.token, form)
=======
class RetrieveHeadFormRequest < FormRequest
  def initialize(form, token = APIConfig.token)
>>>>>>> Reorder parameters to keep rubocop happy:lib/create_api_gem/forms/requests/retrieve_head_form_request.rb
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
