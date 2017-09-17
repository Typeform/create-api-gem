require_relative 'workspace_request'

class RetrieveWorkspaceRequest < WorkspaceRequest
  def initialize(token, workspace)
    request(
      method: :get,
      url: "#{APIConfig.api_request_url}/workspaces/#{workspace.id}",
      headers: {
        'Authorization' => "Bearer #{token}"
      }
    )
  end

  def success?
    @response.code == 200 && json? && json.key?(:forms) && json.key?(:self)
  end
end
