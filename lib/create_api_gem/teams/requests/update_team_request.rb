require_relative 'team_request'

class UpdateTeamRequest < TeamRequest
  def initialize(token = APIConfig.token, operations)
    request(
      method: :patch,
      url: "#{APIConfig.api_request_url}/teams/mine",
      headers: {
        'Authorization' => "Bearer #{token}"
      },
      payload: operations.map(&:payload).to_json
    )
  end

  def success?
    @response.code == 204
  end
end
