require_relative 'workspace_request'

class PatchWorkspaceRequest < WorkspaceRequest
  def initialize(token, workspace, operations)
    request(
      method: :patch,
      url: "#{APIConfig.api_request_url}/workspaces/#{workspace.id}",
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
