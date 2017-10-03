require_relative 'workspace_request'

class DeleteWorkspaceRequest < WorkspaceRequest
  def initialize(token = APIConfig.token, workspace)
    request(
      method: :delete,
      url: "#{APIConfig.api_request_url}/workspaces/#{workspace.id}",
      headers: {
        'Authorization' => "Bearer #{token}"
      }
    )
  end

  def success?
    @response.code == 204
  end

  def invalid_operation?
    @response.code == 400
  end
end
