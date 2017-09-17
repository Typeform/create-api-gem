require_relative 'workspace_request'

class RetrieveAllWorkspacesRequest < WorkspaceRequest
  def initialize(token)
    request(
      method: :get,
      url: "#{APIConfig.api_request_url}/workspaces",
      headers: {
        'Authorization' => "Bearer #{token}"
      }
    )
  end

  def success?
    @response.code == 200 && json?
  end

  def workspaces
    json.fetch(:items).map do |workspace_json|
      Workspace.from_response(workspace_json)
    end
  end
end
