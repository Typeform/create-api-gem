require_relative 'workspace_request'

class RetrieveWorkspaceFormsRequest < WorkspaceRequest
  def initialize(workspace, token = APIConfig.token)
    request(
      method: :get,
      url: "#{APIConfig.api_request_url}/workspaces/#{workspace.id}/forms",
      headers: {
        'Authorization' => "Bearer #{token}"
      }
    )
  end

  def success?
    @response.code == 200 && json?
  end

  def forms
    json.fetch(:items)
  end
end
