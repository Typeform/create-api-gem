require_relative '../../api_request'

class WorkspaceRequest < APIRequest
  def workspace
    Workspace.from_response(json)
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
end
