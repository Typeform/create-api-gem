require_relative '../../api_request'

class TeamRequest < APIRequest
  def team
    Team.from_response(json)
  end

  def not_found?
    @response.code == 404
  end

  def forbidden?
    @response.code == 403
  end

  def bad_request?
    @response.code == 400
  end

  def payment_required?
    @response.code == 402
  end
end
