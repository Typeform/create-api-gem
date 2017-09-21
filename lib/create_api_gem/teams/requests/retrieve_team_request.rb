require_relative 'team_request'

class RetrieveTeamRequest < TeamRequest
  def initialize(token)
    request(
      method: :get,
      url: "#{APIConfig.api_request_url}/teams/mine",
      headers: {
        'Authorization' => "Bearer #{token}"
      }
    )
  end

  def success?
    @response.code == 200 && json? && json.key?(:members) && json.key?(:total_seats)
  end
end
